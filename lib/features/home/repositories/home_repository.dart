import 'package:growstore/features/home/models/home_product_model.dart';
import 'package:growstore/shared/products/services/product_service.dart';

class HomeRepository {
  HomeRepository({ProductService? productService})
    : _productService = productService ?? ProductService();

  final ProductService _productService;

  Future<List<HomeProductModel>> getFeaturedProducts() async {
    final rawProducts = await _productService.fetchAllProducts();

    return rawProducts.map(HomeProductModel.fromJson).toList();
  }
}
