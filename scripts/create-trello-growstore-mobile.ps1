param(
  [string]$PlanPath,
  [string]$MemberMapPath,
  [string]$ProjectStartDate,
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($PlanPath)) {
  $PlanPath = Join-Path $repoRoot "docs\trello\growstore-mobile-3-weeks.json"
}
if ([string]::IsNullOrWhiteSpace($MemberMapPath)) {
  $MemberMapPath = Join-Path $repoRoot "docs\trello\member-map.json"
}

if (-not (Test-Path -LiteralPath $PlanPath)) {
  throw "Plan file not found: $PlanPath"
}

$plan = Get-Content -LiteralPath $PlanPath -Raw | ConvertFrom-Json

if ($DryRun) {
  Write-Host "Dry run: no Trello API calls will be made."
  Write-Host "Project: $($plan.project)"
  Write-Host "Lists: $(@($plan.lists).Count)"
  Write-Host "Cards: $(@($plan.cards).Count)"
  foreach ($card in @($plan.cards)) {
    Write-Host "- [$($card.list)] $($card.name)"
  }
  exit 0
}

foreach ($varName in @("TRELLO_KEY", "TRELLO_TOKEN", "TRELLO_BOARD_ID")) {
  if ([string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($varName))) {
    throw "Missing environment variable: $varName"
  }
}

$baseUrl = "https://api.trello.com/1"
$trelloKey = [Environment]::GetEnvironmentVariable("TRELLO_KEY")
$trelloToken = [Environment]::GetEnvironmentVariable("TRELLO_TOKEN")
$boardId = [Environment]::GetEnvironmentVariable("TRELLO_BOARD_ID")

function Invoke-Trello {
  param(
    [Parameter(Mandatory = $true)][string]$Method,
    [Parameter(Mandatory = $true)][string]$Path,
    [hashtable]$Body
  )

  $separator = "?"
  if ($Path.Contains("?")) {
    $separator = "&"
  }

  $uri = "$baseUrl$Path$separator" +
    "key=$([uri]::EscapeDataString($trelloKey))" +
    "&token=$([uri]::EscapeDataString($trelloToken))"

  if ($null -eq $Body) {
    return Invoke-RestMethod -Method $Method -Uri $uri
  }

  return Invoke-RestMethod -Method $Method -Uri $uri -Body $Body
}

function Get-DueDate {
  param([object]$DueWorkday)

  if ($null -eq $DueWorkday -or [string]::IsNullOrWhiteSpace($ProjectStartDate)) {
    return $null
  }

  $date = [datetime]::Parse($ProjectStartDate).Date.AddHours(18)
  $remaining = [int]$DueWorkday - 1

  while ($remaining -gt 0) {
    $date = $date.AddDays(1)
    if ($date.DayOfWeek -ne [DayOfWeek]::Saturday -and $date.DayOfWeek -ne [DayOfWeek]::Sunday) {
      $remaining--
    }
  }

  return $date.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
}

function Add-PropertyIfValue {
  param(
    [hashtable]$Body,
    [string]$Name,
    [object]$Value
  )

  if ($null -ne $Value -and -not [string]::IsNullOrWhiteSpace([string]$Value)) {
    $Body[$Name] = $Value
  }
}

$memberMap = @{}
if (Test-Path -LiteralPath $MemberMapPath) {
  $memberMapJson = Get-Content -LiteralPath $MemberMapPath -Raw | ConvertFrom-Json
  foreach ($property in $memberMapJson.PSObject.Properties) {
    $memberMap[$property.Name] = @($property.Value)
  }
}

Write-Host "Ensuring Trello lists..."
$existingLists = Invoke-Trello -Method "GET" -Path "/boards/$boardId/lists?fields=name"
$listsByName = @{}
foreach ($list in @($existingLists)) {
  $listsByName[$list.name] = $list.id
}

foreach ($listName in @($plan.lists)) {
  if (-not $listsByName.ContainsKey($listName)) {
    $createdList = Invoke-Trello -Method "POST" -Path "/boards/$boardId/lists" -Body @{ name = $listName }
    $listsByName[$createdList.name] = $createdList.id
    Write-Host "Created list: $($createdList.name)"
  }
}

Write-Host "Ensuring Trello labels..."
$existingLabels = Invoke-Trello -Method "GET" -Path "/boards/$boardId/labels?fields=name,color"
$labelsByName = @{}
foreach ($label in @($existingLabels)) {
  if (-not [string]::IsNullOrWhiteSpace($label.name)) {
    $labelsByName[$label.name] = $label.id
  }
}

foreach ($property in $plan.labelColors.PSObject.Properties) {
  $labelName = $property.Name
  $labelColor = $property.Value

  if (-not $labelsByName.ContainsKey($labelName)) {
    $createdLabel = Invoke-Trello -Method "POST" -Path "/labels" -Body @{
      idBoard = $boardId
      name = $labelName
      color = $labelColor
    }
    $labelsByName[$createdLabel.name] = $createdLabel.id
    Write-Host "Created label: $($createdLabel.name)"
  }
}

Write-Host "Checking existing cards..."
$existingCards = Invoke-Trello -Method "GET" -Path "/boards/$boardId/cards?fields=name"
$existingCardNames = @{}
foreach ($existingCard in @($existingCards)) {
  $existingCardNames[$existingCard.name] = $true
}

Write-Host "Creating cards..."
foreach ($card in @($plan.cards)) {
  if ($existingCardNames.ContainsKey($card.name)) {
    Write-Host "Skipping existing card: $($card.name)"
    continue
  }

  if (-not $listsByName.ContainsKey($card.list)) {
    throw "List not found for card '$($card.name)': $($card.list)"
  }

  $owners = @($card.ownerProfiles)
  $labelIds = @()
  foreach ($labelName in @($card.labels)) {
    if ($labelsByName.ContainsKey($labelName)) {
      $labelIds += $labelsByName[$labelName]
    }
  }

  $memberIds = @()
  foreach ($owner in $owners) {
    if ($memberMap.ContainsKey($owner)) {
      $memberIds += @($memberMap[$owner])
    }
  }
  $memberIds = @($memberIds | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)

  $desc = @"
Prioridade: $($card.priority)
Responsavel/perfil: $($owners -join ", ")

$($card.description)

Fonte: Desafio Final GrowStore - Trilha Mobile Flutter.
"@

  $body = @{
    idList = $listsByName[$card.list]
    name = $card.name
    desc = $desc
    pos = "bottom"
  }

  if ($labelIds.Count -gt 0) {
    $body["idLabels"] = $labelIds -join ","
  }
  if ($memberIds.Count -gt 0) {
    $body["idMembers"] = $memberIds -join ","
  }

  $dueDate = Get-DueDate -DueWorkday $card.dueWorkday
  Add-PropertyIfValue -Body $body -Name "due" -Value $dueDate

  $createdCard = Invoke-Trello -Method "POST" -Path "/cards" -Body $body
  Write-Host "Created card: $($createdCard.name)"

  $checklistItems = @($card.checklist)
  if ($checklistItems.Count -gt 0) {
    $checklist = Invoke-Trello -Method "POST" -Path "/cards/$($createdCard.id)/checklists" -Body @{ name = "Checklist" }
    foreach ($item in $checklistItems) {
      [void](Invoke-Trello -Method "POST" -Path "/checklists/$($checklist.id)/checkItems" -Body @{
        name = $item
        checked = "false"
      })
    }
  }
}

Write-Host "Done."
