import 'product_option_model.dart';
import 'package:growstore/shared/utils/price_utils.dart';

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
    final detail = _firstProductDetail(json['product_details']);
    final galleryUrls = _parseGalleryUrls(json, detail);
    final mainImageUrl = _parseString(
      json['image'] ??
          json['imageUrl'] ??
          json['path_image'] ??
          json['asset'] ??
          detail?['main_image'],
    );

    return ProductDetailsModel(
      uid: _parseString(json['id']),
      name: _parseString(
        json['title'] ?? json['title_product'] ?? json['name'],
        fallback: 'Produto',
      ),
      description: _parseString(
        json['description'] ??
            json['description_product'] ??
            detail?['description'],
      ),
      mainImageUrl: mainImageUrl.isNotEmpty
          ? mainImageUrl
          : (galleryUrls.isNotEmpty ? galleryUrls.first : ''),
      galleryUrls: galleryUrls,
      price: parseGrowPrice(
        json['price'] ?? json['price_product'] ?? detail?['price'],
      ),
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

  static List<String> _parseGalleryUrls(
    Map<String, dynamic> json,
    Map<String, dynamic>? detail,
  ) {
    final rawGallery =
        json['galleryUrls'] ??
        json['images'] ??
        json['gallery'] ??
        detail?['gallery'] ??
        detail?['images'];

    if (rawGallery is List) {
      final urls = rawGallery
          .map((value) => _parseString(value))
          .where((value) => value.isNotEmpty)
          .toList();

      if (urls.isNotEmpty) return urls;
    }

    final image = _parseString(
      json['image'] ??
          json['imageUrl'] ??
          json['path_image'] ??
          json['asset'] ??
          detail?['main_image'],
    );
    return image.isEmpty ? const [] : [image];
  }

  static Map<String, dynamic>? _firstProductDetail(Object? details) {
    if (details is Map) {
      return Map<String, dynamic>.from(details);
    }

    if (details is List && details.isNotEmpty && details.first is Map) {
      return Map<String, dynamic>.from(details.first as Map);
    }

    return null;
  }
}
