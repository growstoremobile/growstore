import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:growstore/shared/products/services/product_service.dart';
import 'package:growstore/shared/utils/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HttpTestOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = HttpTestOverrides();

  setUpAll(() async {
    if (!AppConfig.hasSupabaseConfig) return;

    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      publishableKey: AppConfig.supabaseAnonKey,
      authOptions: FlutterAuthClientOptions(
        localStorage: const EmptyLocalStorage(),
        pkceAsyncStorage: _MemoryGotrueAsyncStorage(),
      ),
    );
  });

  test(
    'ProductService busca produtos normalizados com sucesso',
    () async {
      final produtos = await ProductService().fetchAllProducts();
      final primeiroProduto = produtos.first;

      expect(produtos, isNotEmpty);
      expect(primeiroProduto['title'].toString(), isNotEmpty);
      expect(primeiroProduto['image'].toString(), isNotEmpty);
      expect(primeiroProduto['category'].toString(), isNotEmpty);
      expect(primeiroProduto['price'], isNotNull);
    },
    skip: AppConfig.hasSupabaseConfig
        ? false
        : 'Defina SUPABASE_URL e SUPABASE_ANON_KEY para rodar este teste.',
  );

  test(
    'ProductService busca categorias com imagens com sucesso',
    () async {
      final categorias = await ProductService().fetchCategoriesWithQuantity();

      expect(categorias, isNotEmpty);
      expect(categorias.first['category_images'], isA<List>());
    },
    skip: AppConfig.hasSupabaseConfig
        ? false
        : 'Defina SUPABASE_URL e SUPABASE_ANON_KEY para rodar este teste.',
  );
}

class _MemoryGotrueAsyncStorage extends GotrueAsyncStorage {
  final _storage = <String, String>{};

  @override
  Future<String?> getItem({required String key}) async => _storage[key];

  @override
  Future<void> removeItem({required String key}) async {
    _storage.remove(key);
  }

  @override
  Future<void> setItem({required String key, required String value}) async {
    _storage[key] = value;
  }
}
