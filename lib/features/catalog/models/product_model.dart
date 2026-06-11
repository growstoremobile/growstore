class ProductModel {
  final String id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['dexcription'],
      category: map['category'],
      imageUrl: map['image'],
    );
  }
}
