import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      final response = await _supabase.from('produtos').select();

      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      rethrow;
    }
  }
}
