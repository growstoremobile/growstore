import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('Deve buscar a lista de produtos do Supabase com sucesso', () async {
    // Inicializa o Supabase desativando o armazenamento em cache local do celular
    await Supabase.initialize(
      url: "https://ucdecpenkxmuuwpmmbgt.supabase.co",
      publishableKey: 'sb_publishable_N_m5Da8h_8SVTl-jOKBLxw_FqTa90VV',
      authOptions: const FlutterAuthClientOptions(
        localStorage: EmptyLocalStorage(), // <-- ISSO resolve o erro no teste!
      ),
    );

    final supabase = Supabase.instance.client;

    final response = await supabase.from('produtos').select();

    print('📦 Produtos retornados do banco:\n$response');

    expect(response, isNotNull);
    expect(response, isNotEmpty);
  });
}
