import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  Future<Map<String, dynamic>> fetchAllProducts() async {
    try {
      final resultados = await Future.wait([
        // Consulta 1: Traz os produtos + Categoria + Preço (que está em product_details)
        Supabase.instance.client.from('produtos').select('''
            *, 
            categorias(id_category, name_category),
            product_details(price)
          '''),

        // Consulta 2: Traz as categorias para o contador do menu
        Supabase.instance.client.from('categorias').select('''
            id_category, 
            name_category, 
            produtos(id)
          '''),
      ]);

      // Mapeia a lista geral de produtos
      final todosOsProdutos = List<Map<String, dynamic>>.from(resultados[0]);

      // Mapeia o menu de categorias
      final listaCategorias = List<Map<String, dynamic>>.from(
        (resultados[1] as List).map((item) => Map<String, dynamic>.from(item)),
      );

      // Calcula a quantidade de produtos por categoria
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
