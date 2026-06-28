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
    final galleryUrls = _parseGalleryUrls(json);
    final mainImageUrl = _parseString(
      json['image'] ?? json['imageUrl'] ?? json['path_image'] ?? json['asset'],
    );

    return ProductDetailsModel(
      uid: _parseString(json['id']),
      name: _parseString(
        json['title'] ?? json['title_product'] ?? json['name'],
        fallback: 'Produto',
      ),
      description: _parseString(
        json['description'] ?? json['description_product'],
      ),
      mainImageUrl: mainImageUrl.isNotEmpty
          ? mainImageUrl
          : (galleryUrls.isNotEmpty ? galleryUrls.first : ''),
      galleryUrls: galleryUrls,
      price: _parsePrice(json['price'] ?? json['price_product']),
      options: const [
        ProductOption(
          name: 'Tamanho',
          options: ['PP', 'P', 'M', 'G', 'GG', 'XG'],
        ),
        ProductOption(name: 'Cor', options: ['Preto', 'Branco']),
      ],
    );
  }

  static String _parseString(Object? value, {String fallback = ''}) {
    final parsed = value?.toString().trim() ?? '';
    return parsed.isEmpty ? fallback : parsed;
  }

  static double _parsePrice(Object? value) {
    if (value is num) return value.toDouble();

    var normalized = value?.toString().trim() ?? '';
    normalized = normalized.replaceAll(RegExp(r'[^0-9,.-]'), '');

    if (normalized.contains(',') && normalized.contains('.')) {
      normalized = normalized.replaceAll('.', '').replaceAll(',', '.');
    } else {
      normalized = normalized.replaceAll(',', '.');
    }

    return double.tryParse(normalized) ?? 0;
  }

  static List<String> _parseGalleryUrls(Map<String, dynamic> json) {
    final rawGallery = json['galleryUrls'] ?? json['images'] ?? json['gallery'];

    if (rawGallery is List) {
      final urls = rawGallery
          .map((value) => _parseString(value))
          .where((value) => value.isNotEmpty)
          .toList();

      if (urls.isNotEmpty) return urls;
    }

    final image = _parseString(
      json['image'] ?? json['imageUrl'] ?? json['path_image'] ?? json['asset'],
    );
    return image.isEmpty ? const [] : [image];
  }
}
