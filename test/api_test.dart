import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = null;

  test('Deve buscar a lista de produtos do Supabase com sucesso', () async {
    await Supabase.initialize(
      url: 'https://ucdecpenkxmuuwpmmbgt.supabase.co',
      publishableKey: 'sb_publishable_N_m5Da8h_8SVTl-jOKBLxw_FqTa90VV',
      authOptions: FlutterAuthClientOptions(
        localStorage: const EmptyLocalStorage(),
        pkceAsyncStorage: _MemoryGotrueAsyncStorage(),
      ),
    );

    final supabase = Supabase.instance.client;
    final response = await supabase.from('produtos').select();
    print(response);

    expect(response, isNotNull);
    expect(response, isNotEmpty);
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
