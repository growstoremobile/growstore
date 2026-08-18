# GrowStore Mobile

Aplicativo de e-commerce desenvolvido em Flutter para Android e iOS. O projeto integra Firebase para autenticação, endereços e pedidos; Supabase para o catálogo de produtos; Hive para dados locais; MobX para estado reativo; e GetIt para injeção de dependências.

## 🖼️ Tela (Preview)


<img src="assets/growdev.gif" alt="Demonstração do App" width="300"/>

## Funcionalidades

- Autenticação com e-mail e senha pelo Firebase Authentication.
- Login social com Google.
- Persistência da sessão do usuário.
- Home com produtos e categorias em destaque.
- Busca e filtro de produtos.
- Listagem de categorias e produtos associados.
- Detalhes do produto, galeria, variações e quantidade.
- Favoritos persistidos localmente.
- Carrinho, cupom, frete e checkout.
- Cadastro e consulta de endereços com apoio do ViaCEP.
- Histórico e detalhes de pedidos no Firestore.
- Navegação inferior com contador de itens no carrinho.
- Temas claro e escuro.

## Tecnologias

- Flutter e Dart
- Firebase Authentication e Cloud Firestore
- Google Sign-In
- Supabase/PostgREST
- MobX e `mobx_codegen`
- GetIt
- Hive
- Dio
- `cached_network_image`
- Google Fonts e Material Design

## Plataformas

O código de configuração do Firebase está preparado para:

- Android
- iOS

Web, Windows, macOS e Linux ainda não possuem configuração Firebase neste projeto.

## Pré-requisitos

- Flutter no canal stable, com Dart `>=3.10.7 <4.0.0`.
- Java 17 para compilação Android.
- Android Studio/Android SDK ou Xcode/CocoaPods, conforme a plataforma.
- Acesso ao projeto Firebase da equipe.
- URL e chave pública (`anon`/publishable) do projeto Supabase.
- Keystore de desenvolvimento e respectivas credenciais para Android.

Verifique o ambiente local:

```bash
flutter doctor
flutter devices
```

## Configuração do Firebase

### Arquivos nativos

Obtenha os arquivos no Firebase Console ou com o responsável pelo projeto e coloque-os nos caminhos abaixo:

```text
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```

Esses arquivos estão no `.gitignore` e não devem ser enviados ao repositório.

No Firebase Console, confirme também que:

- O provedor **E-mail/senha** está habilitado.
- O provedor **Google** está habilitado.
- O Cloud Firestore está criado e possui regras adequadas ao ambiente.
- O aplicativo Android possui a SHA-1 da chave utilizada pela equipe.

### SHA-1 para login Google

Com o keystore configurado, execute:

```bash
cd android
./gradlew signingReport
```

No Windows:

```powershell
cd android
.\gradlew signingReport
```

Copie a SHA-1 da variante `debug`, cadastre-a no aplicativo Android do Firebase e baixe novamente o `google-services.json`.

Erros como `ApiException: 10` ou `DEVELOPER_ERROR` normalmente indicam divergência entre a SHA-1 local e a cadastrada no Firebase.

## Assinatura Android

O Gradle utiliza a configuração `development` tanto para `debug` quanto para `release`. Por isso, a compilação Android exige:

```text
android/key.properties
android/<arquivo-da-chave>.jks
```

Exemplo de `android/key.properties`:

```properties
storePassword=SENHA_DO_KEYSTORE
keyPassword=SENHA_DA_CHAVE
keyAlias=ALIAS_DA_CHAVE
storeFile=../debug-keystore.jks
```

O caminho de `storeFile` deve apontar para a localização real do arquivo `.jks`. Solicite o keystore e os valores corretos ao responsável pelo projeto.

`key.properties`, arquivos `.jks` e `.keystore` estão ignorados pelo Git. Nunca publique esses arquivos ou suas senhas.

## Variáveis de ambiente

As configurações são lidas em tempo de compilação com `String.fromEnvironment`. O projeto não carrega automaticamente um arquivo `.env` em runtime.

Crie localmente um arquivo `.env.dev.json` na raiz do projeto. Arquivos iniciados por `.env` estão no `.gitignore`.

### Android

```json
{
  "SUPABASE_URL": "https://SEU-PROJETO.supabase.co",
  "SUPABASE_ANON_KEY": "SUA_CHAVE_PUBLICA_SUPABASE",
  "FIREBASE_ANDROID_API_KEY": "SUA_API_KEY",
  "FIREBASE_ANDROID_APP_ID": "SEU_APP_ID",
  "FIREBASE_ANDROID_MESSAGING_SENDER_ID": "SEU_SENDER_ID",
  "FIREBASE_ANDROID_PROJECT_ID": "SEU_PROJECT_ID",
  "FIREBASE_ANDROID_STORAGE_BUCKET": "SEU_STORAGE_BUCKET"
}
```

### iOS

Para executar no iOS, acrescente ao mesmo arquivo:

```json
{
  "FIREBASE_IOS_API_KEY": "SUA_API_KEY",
  "FIREBASE_IOS_APP_ID": "SEU_APP_ID",
  "FIREBASE_IOS_MESSAGING_SENDER_ID": "SEU_SENDER_ID",
  "FIREBASE_IOS_PROJECT_ID": "SEU_PROJECT_ID",
  "FIREBASE_IOS_STORAGE_BUCKET": "SEU_STORAGE_BUCKET",
  "FIREBASE_IOS_ANDROID_CLIENT_ID": "SEU_ANDROID_CLIENT_ID",
  "FIREBASE_IOS_IOS_CLIENT_ID": "SEU_IOS_CLIENT_ID",
  "FIREBASE_IOS_IOS_BUNCLE_ID": "com.example.growstore"
}
```

> O nome `FIREBASE_IOS_IOS_BUNCLE_ID` mantém a grafia atualmente utilizada pelo código. Alterá-lo exige atualizar também `lib/shared/utils/app_config.dart`.

Sem `SUPABASE_URL` e `SUPABASE_ANON_KEY`, o Supabase não é inicializado e catálogo, categorias e favoritos remotos não funcionarão.

## Instalação

```bash
git clone <URL_DO_REPOSITORIO>
cd growstore
flutter pub get
```

Se os arquivos gerados do MobX/Hive estiverem ausentes ou após alterar models/stores anotados:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Execução

Com Firebase, assinatura Android e variáveis configurados:

```bash
flutter run --dart-define-from-file=.env.dev.json
```

Para escolher um dispositivo:

```bash
flutter devices
flutter run -d <DEVICE_ID> --dart-define-from-file=.env.dev.json
```

## Testes e qualidade

Análise estática:

```bash
flutter analyze
```

Testes unitários e de widgets:

```bash
flutter test
```

Os testes de integração com Supabase são ignorados quando as variáveis não estão disponíveis. Para executá-los:

```bash
flutter test test/api_test.dart --dart-define-from-file=.env.dev.json
```

Testes existentes incluem stores de carrinho, categorias, produtos por categoria, detalhes do produto e widgets principais.

## Estrutura do projeto

```text
lib/
  core/
    di/            # Registro de dependências com GetIt
    errors/        # Erros compartilhados
    routing/       # Rotas e constantes de navegação
    theme/         # Temas, tipografia e estados visuais
  features/
    address/       # Endereços e consulta de CEP
    auth/          # Login, cadastro e sessão
    cart/          # Carrinho e cálculos
    catalog/       # Detalhes e variações de produtos
    categories/    # Categorias e produtos associados
    checkout/      # Fluxo de finalização
    favorites/     # Produtos favoritos
    home/          # Tela inicial
    navigation/    # Navegação principal
    orders/        # Pedidos e histórico
    profile/       # Perfil do usuário
    search/        # Busca e filtros
    splash/        # Inicialização do app
  shared/
    products/      # Serviço compartilhado de produtos
    utils/         # Configurações e utilitários
    widgets/       # Componentes reutilizáveis
test/
```

O fluxo predominante segue a separação:

```text
Page -> Store -> Repository -> Service/API
```

## Backends esperados

### Firebase

- Authentication para login e cadastro.
- Cloud Firestore para endereços e pedidos.

### Supabase

O catálogo consulta produtos, detalhes, categorias e a view de categorias. O ambiente Supabase deve disponibilizar as estruturas esperadas pelos services, incluindo `produtos`, `categorias`, `product_details` e `view_categorias`.

## Problemas comuns

### `google-services.json is missing`

Adicione o arquivo em `android/app/google-services.json` e execute:

```bash
flutter clean
flutter pub get
```

### Erro com `key.properties` ou keystore

Confirme a existência de `android/key.properties`, o caminho de `storeFile`, o alias e as senhas. A configuração Gradle atual exige o keystore inclusive no build de debug.

### Supabase não inicializado

Execute o app com `--dart-define-from-file=.env.dev.json` e confira se `SUPABASE_URL` e `SUPABASE_ANON_KEY` estão preenchidas.

### Arquivos MobX/Hive ausentes ou conflitantes

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Cache de plugins Android inconsistente

```bash
flutter clean
flutter pub get
cd android
./gradlew clean
cd ..
```

## Segurança

Não versione:

- Chaves privadas ou tokens.
- `.env*` com valores reais.
- Arquivos Firebase nativos.
- `key.properties`.
- Keystores `.jks` ou `.keystore`.

As chaves públicas de cliente ainda devem ser tratadas como configuração de ambiente e protegidas por regras adequadas no Firebase e por RLS no Supabase.
