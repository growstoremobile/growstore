import 'package:growstore/features/categories/models/category_model.dart';
import 'package:growstore/features/home/models/home_product_model.dart';
import 'package:growstore/shared/products/services/product_service.dart';

class CategoriesRepository {
  final ProductService _productService;

  CategoriesRepository({required ProductService productService})
    : _productService = productService;

  Future<List<CategoryModel>> getCategories() async {
    final products = await _productService.fetchAllProducts();
    final categoriesById = <int, Map<String, dynamic>>{};

    for (final product in products) {
      final rawCategory = product['categorias'];
      if (rawCategory is! Map) continue;

      final category = Map<String, dynamic>.from(rawCategory);
      final rawId = category['id_category'];
      if (rawId is! num) continue;

      final id = rawId.toInt();
      final accumulatedCategory = categoriesById.putIfAbsent(
        id,
        () => {
          'id_category': id,
          'name_category': category['name_category'],
          'product_qtd': 0,
          'image': '',
        },
      );

      accumulatedCategory['product_qtd'] =
          (accumulatedCategory['product_qtd'] as int) + 1;

      final currentImage = accumulatedCategory['image']?.toString() ?? '';
      final productImage = product['image']?.toString().trim() ?? '';
      if (currentImage.isEmpty && productImage.isNotEmpty) {
        accumulatedCategory['image'] = productImage;
      }
    }

    return categoriesById.values.map(CategoryModel.fromMap).toList();
  }

  Future<List<HomeProductModel>> getProductsByCategory(int categoryId) async {
    final products = await _productService.fetchAllProducts();

    return products
        .where((product) {
          final rawCategory = product['categorias'];
          if (rawCategory is! Map) return false;

          final rawId = rawCategory['id_category'];
          return rawId is num && rawId.toInt() == categoryId;
        })
        .map(HomeProductModel.fromJson)
        .toList();
  }
}
