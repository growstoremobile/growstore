import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      final response = await Supabase.instance.client
          .from('produtos')
          .select('*,categorias(id_category,name_category),product_details(*)');

      return List<Map<String, dynamic>>.from(
        response.map((product) => _normalizeProduct(product)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchCategoriesWithQuantity() async {
    try {
      final responseCategorias = await Supabase.instance.client
          .from('view_categorias')
          .select();

      final listaCategorias = List<Map<String, dynamic>>.from(
        responseCategorias,
      );
      final listaProdutos = await fetchAllProducts();

      for (final categoria in listaCategorias) {
        final idCategoriaAtual = categoria['id_category'];
        final produtosDaCategoria = listaProdutos.where(
          (produto) =>
              produto['id_categoria']?.toString() ==
              idCategoriaAtual?.toString(),
        );

        final imagensDaCategoria = produtosDaCategoria
            .map((produto) {
              final detalhes = _firstProductDetail(produto['product_details']);
              final detailImage = detalhes?['main_image'];
              return (detailImage ?? produto['image'] ?? '').toString();
            })
            .where((url) => url.isNotEmpty)
            .toList();

        categoria['category_images'] = imagensDaCategoria;
      }

      return listaCategorias;
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
    final detail = _firstProductDetail(product['product_details']);
    final image =
        product['image'] ??
        product['imageUrl'] ??
        product['path_image'] ??
        detail?['main_image'];
    final detailPrice = detail?['price'];
    final price =
        product['price'] ?? product['price_product'] ?? detailPrice ?? 0;

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

  Map<String, dynamic>? _firstProductDetail(Object? details) {
    if (details is Map) {
      return Map<String, dynamic>.from(details);
    }

    if (details is List && details.isNotEmpty && details.first is Map) {
      return Map<String, dynamic>.from(details.first as Map);
    }

    return null;
  }
}
