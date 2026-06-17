class CatalogModel {
  final int id;
  final String title;
  final int productQtn;

  CatalogModel({
    required this.id,
    required this.title,
    required this.productQtn,
  });

  factory CatalogModel.fromMap(Map<String, dynamic> map) {
    return CatalogModel(
      id: map['id'],
      title: map['title'],
      productQtn: map['productQtn'],
    );
  }
}
