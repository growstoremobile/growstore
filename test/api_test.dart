import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
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
    await Supabase.initialize(
      url: 'https://ucdecpenkxmuuwpmmbgt.supabase.co',
      publishableKey: 'sb_publishable_N_m5Da8h_8SVTl-jOKBLxw_FqTa90VV',
      authOptions: FlutterAuthClientOptions(
        localStorage: const EmptyLocalStorage(),
        pkceAsyncStorage: _MemoryGotrueAsyncStorage(),
      ),
    );
  });

  test('Deve buscar a lista de produtos do Supabase com sucesso', () async {
    final supabase = Supabase.instance.client;

    // Executa a busca real no seu banco de dados
    final response = await supabase.from('produtos').select();

    // Validações
    expect(response, isNotNull);
    expect(response, isNotEmpty);
    expect(response.length, greaterThan(0));

    print('Produtos retornados: $response');
  });
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
