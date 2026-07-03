import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:growstore/features/catalog/models/product_detail_model.dart';

class ProductDetailService {
  ProductDetailService({SupabaseClient? client}) : _client = client;

  final SupabaseClient? _client;

  Future<ProductDetailsModel> getProductById(String id) async {
    final supabaseClient = _client ?? Supabase.instance.client;

    try {
      final response = await supabaseClient
          .from('produtos')
          .select('*,categorias(id_category,name_category),product_details(*)')
          .eq('id', id)
          .single();

      debugPrint('=== [ProductDetailService] response completo ===');
      debugPrint('$response');

      final details = response['product_details'];
      debugPrint(
        '=== [ProductDetailService] product_details tipo: ${details.runtimeType} ===',
      );
      debugPrint('=== [ProductDetailService] product_details: $details ===');

      if (details is List) {
        for (int i = 0; i < details.length; i++) {
          debugPrint(
            '=== [ProductDetailService] detail[$i]: ${details[i]} ===',
          );
        }
      }

      return ProductDetailsModel.fromJson(response);
    } catch (error, stack) {
      debugPrint('=== [ProductDetailService] ERRO: $error ===');
      debugPrint('$stack');
      rethrow;
    }
  }
}
