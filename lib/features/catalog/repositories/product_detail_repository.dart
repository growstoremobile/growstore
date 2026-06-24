import 'package:growstore/features/catalog/models/product_detail_model.dart';
import 'package:growstore/features/catalog/services/product_detail_service.dart';

class ProductDetailRepository {
  final ProductDetailService _service;

  ProductDetailRepository({required ProductDetailService service})
    : _service = service;

  Future<ProductDetailsModel> getProductById(String id) async {
    return await _service.getProductById(id);
  }
}
