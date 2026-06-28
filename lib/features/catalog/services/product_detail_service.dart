import 'package:growstore/features/catalog/models/product_detail_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetailService {
  Future<ProductDetailsModel> getProductById(String id) async {
    final response = await Supabase.instance.client
        .from('produtos')
        .select('*,categorias(id_category,name_category),product_details(*)')
        .eq('id', id)
        .single();

    return ProductDetailsModel.fromJson(response);
  }
}
