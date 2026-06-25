import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:growstore/features/catalog/models/product_detail_model.dart';

class ProductDetailService {
  final _supabase = Supabase.instance.client;

  Future<ProductDetailsModel> getProductById(String id) async {
    final response = await _supabase
        .from('produtos')
        .select()
        .eq('id', id)
        .single();

    return ProductDetailsModel.fromJson(response);
  }
}
