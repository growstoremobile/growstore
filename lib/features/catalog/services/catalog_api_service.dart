import 'package:flutter/services.dart';
import 'package:growstore/features/catalog/models/catalog_model.dart';

class CatalogApiService {
  Future responseCatalog() async {
    final response = await rootBundle.loadString('assets/mocks/catalog.json');

    return (response as List).map((item) => CatalogModel.fromMap(item));
  }
}
