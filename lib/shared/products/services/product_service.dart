import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  /// Faz uma única chamada no repositório que resolve o banco em paralelo,
  /// retornando a listagem geral de produtos E o menu de categorias com contadores.
  Future<Map<String, dynamic>> fetchAllProducts() async {
    try {
      // Executa as duas consultas ao mesmo tempo (ganho de performance)
      final resultados = await Future.wait([
        // Consulta 1: Todos os produtos direto da tabela de produtos
        Supabase.instance.client
            .from('produtos')
            .select('*, categorias(id_category, name_category)'),

        // Consulta 2: Categorias para fazermos a contagem
        Supabase.instance.client
            .from('categorias')
            .select('id_category, name_category, produtos(id)'),
      ]);

      // 1. Tratando a listagem geral de produtos
      final todosOsProdutos = List<Map<String, dynamic>>.from(resultados[0]);

      // 2. Tratando as categorias e injetando a contagem (product_qtd)
      final listaCategorias = List<Map<String, dynamic>>.from(
        (resultados[1] as List).map((item) => Map<String, dynamic>.from(item)),
      );

      for (var categoria in listaCategorias) {
        final listaProdutosRelacionados = categoria['produtos'] as List? ?? [];
        categoria['product_qtd'] = listaProdutosRelacionados.length;

        // Removemos a lista de ids fakes para o JSON da categoria não vir pesado
        categoria.remove('produtos');
      }

      // Retorna os dois blocos de dados em um único mapa
      return {
        'produtos_geral': todosOsProdutos,
        'categorias_menu': listaCategorias,
      };
    } catch (_) {
      rethrow;
    }
  }
}
