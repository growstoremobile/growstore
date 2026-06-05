# Planejamento Trello - GrowStore Mobile Flutter

Fonte: `C:\Users\Vinicius\Downloads\Desafio_Final_GrowStore.pdf`, Trilha 03 Mobile.

Escopo: criar apenas o aplicativo mobile Flutter para Android/iOS, com MobX, GetIt, Hive, Firebase Auth, API REST, tema claro GrowStore, testes e README completo.

## Listas sugeridas no Trello

- Backlog
- Semana 1
- Semana 2
- Semana 3
- Em andamento
- Revisao / QA
- Concluido
- Bloqueios

## Time de 10 pessoas

Como ainda nao temos nomes, os cards usam perfis. Depois basta mapear cada perfil para um membro real do Trello.

- P01 Tech Lead / Arquitetura
- P02 Auth / Firebase
- P03 Catalogo / Home
- P04 PDP / Variacoes
- P05 Carrinho / Checkout
- P06 Favoritos / Hive
- P07 Perfil / Pedidos / Enderecos
- P08 API / Services / Mock
- P09 UI / Tema / Componentes
- P10 QA / Testes / Docs

## Semana 1 - Fundacao e autenticacao

Objetivo: sair do template padrao Flutter e criar a base tecnica para o app inteiro.

- W1 - Kickoff tecnico e divisao de responsabilidades
- W1 - Configurar dependencias mobile obrigatorias
- W1 - Criar arquitetura por feature e core compartilhado
- W1 - Definir tema claro GrowStore e componentes visuais base
- W1 - Configurar navegacao com rotas nomeadas
- W1 - Modelar entidades de dominio do app
- W1 - Implementar client HTTP e camada de services
- W1 - Configurar Firebase Auth e login Google
- W1 - Implementar splash e restauracao de sessao
- W1 - Implementar login e cadastro por e-mail/senha
- W1 - Criar API mock inicial para catalogo e pedidos
- W1 - Setup de qualidade, lint e README inicial

## Semana 2 - Catalogo, carrinho, favoritos e area do usuario

Objetivo: entregar os principais fluxos funcionais do app.

- W2 - Implementar Home com banner rotativo e destaques
- W2 - Implementar listagem por categoria com busca e filtros
- W2 - Implementar detalhe do produto com galeria e variacoes
- W2 - Implementar favoritos com persistencia Hive
- W2 - Implementar store do carrinho e feedback ao adicionar
- W2 - Implementar tela de carrinho com Dismissible e subtotal
- W2 - Implementar perfil e logout
- W2 - Implementar gerenciamento de enderecos
- W2 - Implementar historico e detalhe de pedidos
- W2 - Aplicar estados loading, erro e vazio nas telas de dados
- W2 - Criar testes unitarios iniciais para stores e services

## Semana 3 - Checkout, QA, documentacao e entrega

Objetivo: fechar fluxo de compra, estabilizar, testar e preparar apresentacao.

- W3 - Implementar checkout simulado e criacao de pedido
- W3 - Integrar JWT no fluxo autenticado completo
- W3 - Implementar tratamento global de erros
- W3 - Polimento visual, responsividade e animacoes
- W3 - Fechar minimo de 8 testes unitarios
- W3 - QA manual completo em emulador Android/iOS
- W3 - README final com instalacao, execucao e configuracoes
- W3 - Preparar apresentacao de 10 a 15 minutos
- W3 - Revisao final de entrega e higiene do repositorio

## Backlog de diferenciais

- Backlog - Tema escuro com alternancia
- Backlog - Rastreamento de pedido com Google Maps simulado
- Backlog - Push notifications com Firebase Cloud Messaging
- Backlog - Internacionalizacao pt-BR e en-US

## Como criar no Trello

1. Pegue a chave em `https://trello.com/app-key`.
2. Gere o token pelo link `token` da mesma pagina.
3. Pegue o ID do board com:

```powershell
$env:TRELLO_KEY = "sua_chave"
$env:TRELLO_TOKEN = "seu_token"

Invoke-RestMethod "https://api.trello.com/1/members/me/boards?key=$env:TRELLO_KEY&token=$env:TRELLO_TOKEN&fields=name,url" |
  Select-Object id,name,url
```

4. Configure as variaveis e rode o script:

```powershell
$env:TRELLO_KEY = "sua_chave"
$env:TRELLO_TOKEN = "seu_token"
$env:TRELLO_BOARD_ID = "id_do_board"

.\scripts\create-trello-growstore-mobile.ps1 -DryRun
.\scripts\create-trello-growstore-mobile.ps1
```

Opcionalmente, copie `docs\trello\member-map.example.json` para `docs\trello\member-map.json` e substitua os valores pelos IDs dos membros do Trello para atribuir os cards automaticamente.
