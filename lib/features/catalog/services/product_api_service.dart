import 'package:flutter/services.dart';
import 'package:growstore/features/catalog/models/product_model.dart';

class ProductApiService {
  Future responseProduct() async {
    final response = await rootBundle.loadString('assets/mocks/products.json');

    return (response as List).map((item) => ProductModel.fromMap(item));
  }
}
