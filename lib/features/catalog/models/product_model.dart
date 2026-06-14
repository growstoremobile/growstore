class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final int categoryId;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.imageUrl,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      price: map['price'].toDouble(),
      description: map['description'],
      categoryId: map['categoryId'],
      imageUrl: map['image'],
    );
  }
}
