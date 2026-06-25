# Growstore

## Sobre o Projeto

O **Growstore** é um aplicativo mobile desenvolvido em Flutter para Android e iOS, com o objetivo de oferecer uma experiência completa de loja virtual.

A aplicação permite que os clientes naveguem pelo catálogo de produtos, gerenciem favoritos, adicionem itens ao carrinho, realizem checkout e acompanhem seus pedidos.

O projeto tem foco em uma interface fluida, responsiva e alinhada às boas práticas de UX mobile, utilizando **MobX** para gerenciamento de estado global e integração com API REST para consumo de dados reais.

## Funcionalidades

### Autenticação

- Tela de splash screen com logo da Growstore
- Tela de login com e-mail e senha
- Tela de cadastro com nome, e-mail, senha e confirmação de senha
- Login social com Google via Firebase Authentication
- Logout com limpeza do estado global
- Persistência da sessão entre aberturas do app com token salvo localmente usando Hive

### Catálogo de Produtos

- Tela inicial com banner rotativo e lista de produtos em destaque
- Listagem de produtos por categoria
- Busca de produtos por nome
- Filtros para facilitar a navegação no catálogo
- Tela de detalhe do produto com galeria de imagens, variações, preço e descrição
- Alternância entre visualização em GridView e ListView
- Scroll infinito ou paginação na listagem de produtos

### Carrinho de Compras

- Adição de produtos ao carrinho com seleção de variação e quantidade
- Tela de carrinho com lista de itens, subtotal e botão de finalizar compra
- Atualização de quantidade dos itens
- Remoção de itens utilizando gesto Dismissible
- Animação de feedback ao adicionar um produto ao carrinho

### Favoritos

- Adicionar e remover produtos dos favoritos
- Tela com lista de produtos favoritos
- Persistência dos favoritos entre sessões usando armazenamento local com Hive

### Perfil e Pedidos

- Tela de perfil com dados do usuário logado
- Histórico de pedidos
- Exibição de status dos pedidos:
  - PENDING
  - PROCESSING
  - SHIPPED
  - DELIVERED
- Tela de detalhe do pedido com itens e valores
- Gerenciamento de endereços de entrega

### Integração com API

- Consumo de dados reais por meio de API REST
- Integração com API própria, MockAPI ou JSON Server
- Tratamento de estados de carregamento
- Tratamento de erros
- Tratamento de listas vazias
- Autenticação via JWT integrada ao app

## Tecnologias Utilizadas

- Flutter
- Dart
- Material Design
- MobX
- Firebase Authentication
- Hive
- API REST
- JWT

## Configuração Firebase

O login social com Google utiliza Firebase Authentication.

### Arquivos necessários

Os arquivos abaixo não são versionados no repositório e devem ser adicionados manualmente:

**Android**

```text
android/app/google-services.json
```

**iOS**

```text
ios/Runner/GoogleService-Info.plist
```

### Configuração Android

1. Criar um projeto no Firebase Console.
2. Registrar o aplicativo Android.
3. Baixar o arquivo `google-services.json`.
4. Adicionar o arquivo em:

```text
android/app/google-services.json
```

5. Executar:

```bash
flutterfire configure
```

### Configuração iOS

1. Registrar o aplicativo iOS no Firebase.
2. Baixar o arquivo `GoogleService-Info.plist`.
3. Adicionar o arquivo em:

```text
ios/Runner/GoogleService-Info.plist
```

4. Executar:

```bash
flutterfire configure
```

### Executando o projeto

```bash
flutter pub get
flutter run
```

## Login com Google

A autenticação social foi implementada utilizando:

- Firebase Authentication
- Google Sign-In

Fluxos implementados:

- Login com conta Google
- Logout utilizando Firebase Authentication
- Tratamento de sucesso na autenticação
- Tratamento de cancelamento do login
- Tratamento de erros de autenticação

## Plataformas Suportadas

- Android
- iOS
## Estrutura do Projeto

```txt
lib/
│
├── core/
│   ├── config/
│   ├── errors/
│   ├── http/
│   ├── routing/
│   ├── storage/
│   └── theme/
│
├── features/
│   ├── auth/
│   │   ├── pages/
│   │   ├── repositories/
│   │   ├── stores/
│   │   ├── services/
│   │   └── widgets/
│   │
│   └── catalog/
│       ├── pages/
│       ├── repositories/
│       ├── stores/
│       ├── services/
│       └── widgets/
│
├── shared/
│   ├── widgets/
│   └── extensions/
│
└── main.dart
```