import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      // O '*' já traz TODOS os campos do produto (incluindo a coluna de imagem que está nele).
      // E o 'categorias(...)' traz os dados da tabela relacionada.
      final response = await Supabase.instance.client.from('produtos').select(
        '''
            *, 
            categorias(id_category, name_category)
          ''',
      );

      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      rethrow;
    }
  }
}
