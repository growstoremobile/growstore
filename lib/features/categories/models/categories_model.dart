class CategoryModel {
  final int id;
  final String title;

  CategoryModel({required this.id, required this.title});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['categorias']['id_category'],
      title: map['title'],
    );
  }
}
