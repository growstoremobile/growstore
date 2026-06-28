// import 'package:supabase_flutter/supabase_flutter.dart';

// class ProductService {
//   // 1. Método existente (tabela produtos)
//   Future<List<Map<String, dynamic>>> fetchAllProducts() async {
//     try {
//       // O primeiro '*' traz tudo de 'produtos'
//       // O 'product_details(*)' faz o JOIN e traz todas as colunas da tabela de detalhes
//       final response = await Supabase.instance.client.from('produtos').select(
//         '''
//             *,
//             product_details(*)
//           ''',
//       );

//       return List<Map<String, dynamic>>.from(response);
//     } catch (_) {
//       rethrow;
//     }
//   }

//   // 2. NOVO MÉTODO: Consumindo a View que você criou
//   Future<List<Map<String, dynamic>>> fetchCategoriesWithQuantity() async {
//     try {
//       // Basta trocar o nome da tabela pelo nome exato da sua view
//       final response = await Supabase.instance.client
//           .from('view_categorias')
//           .select();

//       return List<Map<String, dynamic>>.from(response);
//     } catch (_) {
//       rethrow;
//     }
//   }
// }

import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  // 1. Método de produtos - Trazendo tudo com os detalhes corretos
  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      final response = await Supabase.instance.client.from('produtos').select(
        '''
            *,
            product_details(*)
          ''',
      );

      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      rethrow;
    }
  }

  // 2. Método de Categorias Modificado: Agora cruza os dados para embutir as imagens
  Future<List<Map<String, dynamic>>> fetchCategoriesWithQuantity() async {
    try {
      // Busca a lista de categorias através da sua View do Supabase
      final responseCategorias = await Supabase.instance.client
          .from('view_categorias')
          .select();

      final listaCategorias = List<Map<String, dynamic>>.from(
        responseCategorias,
      );

      // Busca os produtos para capturar as imagens correspondentes
      final listaProdutos = await fetchAllProducts();

      // Mapeia as categorias inserindo os links de imagens dos produtos vinculados a elas
      for (var categoria in listaCategorias) {
        final idCategoriaAtual = categoria['id_category'];

        // Filtra os produtos que pertencem a esta categoria específica
        final produtosDaCategoria = listaProdutos.where(
          (produto) => produto['id_categoria'] == idCategoriaAtual,
        );

        // Extrai as imagens ('main_image') dos detalhes desses produtos filtrados
        final List<String> imagensDaCategoria = produtosDaCategoria
            .map((produto) {
              final detalhes =
                  produto['product_details'] as Map<String, dynamic>?;
              return detalhes?['main_image'] as String? ?? '';
            })
            .where((url) => url.isNotEmpty) // Remove campos vazios se houverem
            .toList();

        // Adiciona a nova chave com a lista de imagens correspondentes
        categoria['category_images'] = imagensDaCategoria;
      }

      return listaCategorias;
    } catch (_) {
      rethrow;
    }
  }
}
