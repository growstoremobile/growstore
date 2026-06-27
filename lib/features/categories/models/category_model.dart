class CategoryModel {
  final int id;
  final String title;
  final int productQtn;

  CategoryModel({
    required this.id,
    required this.title,
    required this.productQtn,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      title: map['title'],
      productQtn: map['productQtn'],
    );
  }
}
