import 'product_option_model.dart';

class ProductDetailsModel {
  final String uid;
  final String name;
  final String description;
  final String mainImageUrl;
  final List<String> galleryUrls;
  final double price;
  final List<ProductOption> options;

  const ProductDetailsModel({
    required this.uid,
    required this.name,
    required this.description,
    required this.mainImageUrl,
    required this.galleryUrls,
    required this.price,
    this.options = const [],
  });

  bool get hasOptions => options.isNotEmpty;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      uid: json['id'].toString(),
      name: json['title'] ?? '',
      description: json['description'] ?? '',
      mainImageUrl: json['image'] ?? '',
      galleryUrls: [json['image'] ?? ''],
      price: (json['price'] as num).toDouble(),
      options: const [
        ProductOption(
          name: 'Tamanho',
          options: ['PP', 'P', 'M', 'G', 'GG', 'XG'],
        ),
        ProductOption(name: 'Cor', options: ['Preto', 'Branco']),
      ],
    );
  }
}
