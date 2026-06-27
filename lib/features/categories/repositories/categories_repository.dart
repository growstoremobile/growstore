import 'package:growstore/features/categories/models/categories_model.dart';
import 'package:growstore/shared/products/services/product_service.dart';

class CategoriesRepository {
  final ProductService _productService;

  CategoriesRepository({required ProductService productService})
    : _productService = productService;

  Future<List<CategoryModel>> getCategories() async {
    final rawProducts = await _productService.fetchAllProducts();

    return rawProducts.map(CategoryModel.fromMap).toList();
  }
}
