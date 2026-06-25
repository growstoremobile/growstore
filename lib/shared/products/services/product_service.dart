import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      final response = await Supabase.instance.client.from('produtos').select();

      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      rethrow;
    }
  }
}
