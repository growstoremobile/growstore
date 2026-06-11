import 'package:dio/dio.dart';
import 'package:growstore/features/catalog/models/product_model.dart';

class ProductApiService {
  late Dio _dio;

  ProductApiService() {
    _dio = Dio();
  }

  Future responseProduct() async {
    final response = await _dio.get('https://fakestoreapi.com/products/');

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar os produtos na API');
    }

    return (response.data as List).map((item) => ProductModel.fromMap(item));
  }
}
