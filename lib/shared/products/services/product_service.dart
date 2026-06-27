import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  Future<Map<String, dynamic>> fetchAllProducts() async {
    try {
      final resultados = await Future.wait([
        Supabase.instance.client
            .from('produtos')
            .select('*, categorias(id_category, name_category)'),

        Supabase.instance.client
            .from('categorias')
            .select('id_category, name_category, produtos(id)'),
      ]);

      final todosOsProdutos = List<Map<String, dynamic>>.from(resultados[0]);

      final listaCategorias = List<Map<String, dynamic>>.from(
        (resultados[1] as List).map((item) => Map<String, dynamic>.from(item)),
      );

      for (var categoria in listaCategorias) {
        final listaProdutosRelacionados = categoria['produtos'] as List? ?? [];
        categoria['product_qtd'] = listaProdutosRelacionados.length;

        categoria.remove('produtos');
      }

      return {
        'produtos_geral': todosOsProdutos,
        'categorias_menu': listaCategorias,
      };
    } catch (_) {
      rethrow;
    }
  }
}
