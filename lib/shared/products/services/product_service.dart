import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  // Pega o cliente que já foi inicializado lá no main.dart
  final _supabase = Supabase.instance.client;

  // Método para buscar TODOS os produtos
  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      final response = await _supabase
          .from('produtos')
          .select(); // Sem filtros traz tudo

      print(response);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Erro ao buscar produtos: $e");
      rethrow;
    }
  }
}
