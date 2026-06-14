import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:growstore/features/catalog/models/product_model.dart';

class ProductApiService {
  Future responseProduct() async {
    final response = await rootBundle.loadString('assets/mocks/products.json');
    final data = jsonDecode(response) as List;

    return (data).map((item) => ProductModel.fromMap(item));
  }
}
