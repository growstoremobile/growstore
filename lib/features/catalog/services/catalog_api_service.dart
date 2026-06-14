import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:growstore/features/catalog/models/catalog_model.dart';

class CatalogApiService {
  Future responseCatalog() async {
    final response = await rootBundle.loadString('assets/mocks/catalogs.json');
    final data = jsonDecode(response) as List;

    return (data).map((item) => CatalogModel.fromMap(item));
  }
}
