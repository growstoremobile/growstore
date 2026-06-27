import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:growstore/features/categories/models/category_model.dart';

abstract interface class CategoryService {
  Future<List<CategoryModel>> getCategories();
}

class CategoryMockService implements CategoryService {
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await rootBundle.loadString(
        'assets/mocks/categories.json',
      );
      final data = jsonDecode(response) as List;

      return data.map((item) => CategoryModel.fromMap(item)).toList();
    } catch (_) {
      throw Exception('Erro ao carregar categorias');
    }
  }
}
