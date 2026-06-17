import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:growstore/features/catalog/models/catalog_model.dart';

abstract interface class CatalogService {
  Future<List<CatalogModel>> getCatalogs();
}

class CatalogMockService implements CatalogService {
  @override
  Future<List<CatalogModel>> getCatalogs() async {
    final response = await rootBundle.loadString('assets/mocks/catalogs.json');
    final data = jsonDecode(response) as List;

    return (data).map((item) => CatalogModel.fromMap(item)).toList();
  }
}
