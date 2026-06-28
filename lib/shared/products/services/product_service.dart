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
//           .from('view_categories')
//           .select();

//       return List<Map<String, dynamic>>.from(response);
//     } catch (_) {
//       rethrow;
//     }
//   }
// }

import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  // 1. Método existente: Lista os produtos base
  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      final response = await Supabase.instance.client.from('produtos').select();
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      rethrow;
    }
  }

  // 2. Método existente: Consome a sua View de categorias
  Future<List<Map<String, dynamic>>> fetchCategoriesWithQuantity() async {
    try {
      final response = await Supabase.instance.client
          .from('view_categories')
          .select();
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      rethrow;
    }
  }

  // 3. NOVO MÉTODO: Busca os detalhes (preço, descrição, etc.) direto da tabela de detalhes
  Future<List<Map<String, dynamic>>> fetchAllProductDetails() async {
    try {
      // Batemos direto na tabela "product_details" para trazer o preço e demais dados do seu SQL
      final response = await Supabase.instance.client
          .from('product_details')
          .select();

      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      rethrow;
    }
  }
}
