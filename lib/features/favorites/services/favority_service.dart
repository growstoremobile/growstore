import 'package:supabase_flutter/supabase_flutter.dart';

class FavorityService {
  final _supabase = Supabase.instance.client;

  // Busca os dados completos de produtos específicos baseado em uma lista de IDs
  Future<List<Map<String, dynamic>>> fetchProductsByIds(List<int> ids) async {
    if (ids.isEmpty) return [];

    try {
      final response = await _supabase
          .from('produtos')
          .select('*,product_details(*)')
          .inFilter('id', ids);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }
}
