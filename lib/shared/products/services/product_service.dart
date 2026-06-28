import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      final response = await Supabase.instance.client
          .from('produtos')
          .select('*,categorias(id_category,name_category)');

      return List<Map<String, dynamic>>.from(
        response.map((product) => _normalizeProduct(product)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Map<String, dynamic> _normalizeProduct(Map<String, dynamic> product) {
    final rawCategory = product['categorias'];
    final category = rawCategory is Map
        ? rawCategory['name_category']
        : product['category'] ?? product['categoria'];
    final categoryName = category?.toString().trim();
    final title = product['title'] ?? product['title_product'];
    final image =
        product['image'] ?? product['imageUrl'] ?? product['path_image'];
    final price = product['price'] ?? product['price_product'] ?? 0;

    return {
      ...product,
      'title': title?.toString().trim().isNotEmpty == true ? title : 'Produto',
      'image': image ?? '',
      'price': price,
      'category': categoryName == null || categoryName.isEmpty
          ? 'Produto'
          : categoryName,
    };
  }
}
