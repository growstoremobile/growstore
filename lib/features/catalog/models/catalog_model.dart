import 'package:growstore/features/catalog/models/product_model.dart';

class CatalogModel {
  final int id;
  final String title;
  final List<ProductModel>? products;

  CatalogModel({required this.id, required this.title, this.products});

  factory CatalogModel.fromMap(Map<String, dynamic> map) {
    return CatalogModel(id: map['id'], title: map['title']);
  }
}
