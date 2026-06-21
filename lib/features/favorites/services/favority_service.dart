import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteService {
  final _supabase = Supabase.instance.client;

  // Busca os dados completos de produtos específicos baseado em uma lista de IDs
  Future<List<Map<String, dynamic>>> fetchProductsByIds(List<int> ids) async {
    if (ids.isEmpty) return [];

    try {
      final response = await _supabase
          .from('produtos')
          .select()
          .inFilter(
            'id',
            ids,
          ); // Filtra trazendo apenas os produtos favoritados

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }
}
