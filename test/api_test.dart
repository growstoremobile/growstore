import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:growstore/shared/products/services/product_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// IMPORTANTE: Lembre-se de importar o seu ProductService aqui!
// import 'package:seu_projeto/services/product_service.dart';

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
    await Supabase.initialize(
      url: 'https://ucdecpenkxmuuwpmmbgt.supabase.co',
      publishableKey: 'sb_publishable_N_m5Da8h_8SVTl-jOKBLxw_FqTa90VV',
      authOptions: FlutterAuthClientOptions(
        localStorage: const EmptyLocalStorage(),
        pkceAsyncStorage: _MemoryGotrueAsyncStorage(),
      ),
    );
  });

  test(
    'Deve buscar a lista de produtos com detalhes e categorias com sucesso',
    () async {
      // 1. Instancia o seu service real
      final productService = ProductService();

      // 2. Testa o método que faz o JOIN com os detalhes (e traz o preço!)
      final produtos = await productService.fetchAllProducts();

      expect(produtos, isNotNull);
      expect(produtos, isNotEmpty);

      print('--- PRODUTOS E DETALHES (DEVE TRAZER PRODUCT_DETAILS) ---');
      print(produtos);

      // 3. Testa o método que consome a sua View de categorias
      final categorias = await productService.fetchCategoriesWithQuantity();

      expect(categorias, isNotNull);
      expect(categorias, isNotEmpty);

      print('\n--- MENU DE CATEGORIAS (VIEW DO SUPABASE) ---');
      print(categorias);
    },
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
