# GrowStore Mobile

Aplicativo Flutter da GrowStore para Android e iOS. O app permite autenticação, navegação pelo catálogo, favoritos, carrinho, checkout simulado, endereços de entrega e histórico de pedidos.

## Funcionalidades

- Splash screen com identidade GrowStore.
- Login e cadastro com e-mail/senha via Firebase Authentication.
- Login social com Google.
- Persistência de sessão com Hive.
- Home com banner/carrossel e produtos em destaque.
- Busca e listagem por categoria com filtros, GridView/ListView e carregamento incremental.
- Detalhe do produto com galeria, preço, descrição, variações e seleção de quantidade.
- Carrinho com subtotal, frete, desconto, alteração de quantidade e remoção com Dismissible.
- Checkout simulado com endereço padrão de entrega.
- Favoritos persistidos com Hive.
- Perfil com dados do usuário, logout e gerenciamento de endereços.
- Histórico e detalhe de pedidos com status e valores.
- Tema claro e tema escuro.

## Tecnologias

- Flutter e Dart
- MobX
- GetIt
- Hive
- Firebase Authentication
- Google Sign-In
- Supabase/PostgREST para catálogo
- cached_network_image

## Configuração

Crie os arquivos Firebase localmente. Eles são ignorados pelo Git:

```text
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
macos/Runner/GoogleService-Info.plist
lib/firebase_options.dart
```

O app já vem configurado com o ambiente padrão do Supabase do projeto. Para trocar de ambiente, use variáveis de compilação:

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://seu-projeto.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=sua-chave-publica-anon
```

Para rodar os testes de integração com Supabase:

```bash
flutter test \
  --dart-define=SUPABASE_URL=https://seu-projeto.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=sua-chave-publica-anon
```

Sem essas variáveis, os testes de API usam o ambiente padrão do projeto.

## Execução

```bash
flutter pub get
flutter run
```

## Testes

```bash
flutter analyze
flutter test
```

## Estrutura

```text
lib/
  core/
  features/
    auth/
    cart/
    catalog/
    categories/
    favorites/
    home/
    orders/
    profile/
    search/
    splash/
  shared/
```

## Observações de entrega

- Não versionar chaves reais, tokens ou arquivos Firebase gerados.
- Para avaliação em outro ambiente, fornecer `SUPABASE_URL` e `SUPABASE_ANON_KEY`.
- Adicionar screenshots ou vídeo demonstrativo antes da entrega final no GitHub.
