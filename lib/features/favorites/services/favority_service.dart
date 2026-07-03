import 'package:supabase_flutter/supabase_flutter.dart';

class FavorityService {
  Future<List<Map<String, dynamic>>> fetchProductsByIds(List<int> ids) async {
    if (ids.isEmpty) return [];

    final response = await Supabase.instance.client
        .from('produtos')
        .select('*,product_details(*)')
        .inFilter('id', ids);

    return List<Map<String, dynamic>>.from(response);
  }
}
