class CategoryModel {
  final int id;
  final String title;
  final int productQtn;
  final String imageUrl;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.productQtn,
    required this.imageUrl,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: (map['id_category'] as num).toInt(),
      title: map['name_category'].toString(),
      productQtn: (map['product_qtd'] as num).toInt(),
      imageUrl: map['image']?.toString() ?? '',
    );
  }
}
