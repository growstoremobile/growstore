class CatalogModel {
  final int id;
  final String title;
  final int catalogQtn;

  CatalogModel({
    required this.id,
    required this.title,
    required this.catalogQtn,
  });

  factory CatalogModel.fromMap(Map<String, dynamic> map) {
    return CatalogModel(
      id: map['id'],
      title: map['title'],
      catalogQtn: map['catalogQtn'],
    );
  }
}
