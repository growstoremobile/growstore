import 'product_option_model.dart';

class ColorVariation {
  final String colorName;
  final String? colorHex;
  final List<String> galleryImages;

  const ColorVariation({
    required this.colorName,
    this.colorHex,
    required this.galleryImages,
  });
}

class ProductDetailsModel {
  final String uid;
  final String name;
  final String description;
  final String mainImageUrl;
  final List<String> galleryUrls;
  final double price;
  final int categoryId;
  final List<ProductOption> options;
  final List<ColorVariation> colorVariations;

  const ProductDetailsModel({
    required this.uid,
    required this.name,
    required this.description,
    required this.mainImageUrl,
    required this.galleryUrls,
    required this.price,
    required this.categoryId,
    this.options = const [],
    this.colorVariations = const [],
  });

  bool get hasOptions => options.isNotEmpty;

  bool get hasSizeOptions {
    final normalizedName = name.toLowerCase();
    return categoryId == 21 ||
        normalizedName.contains('camiseta') ||
        normalizedName.contains('tshirt');
  }

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    final detail = _firstProductDetail(json['product_details']);
    final gallery = _parseGalleryUrls(json, detail);
    final colorVars = _parseColorVariations(json['product_details']);

    return ProductDetailsModel(
      uid: json['id'].toString(),
      name: json['title_product'] ?? json['title'] ?? '',
      description: detail?['description'] ?? json['description'] ?? '',
      mainImageUrl: gallery.isNotEmpty
          ? gallery.first
          : (json['path_image'] ??
                json['image'] ??
                detail?['main_image'] ??
                ''),
      galleryUrls: gallery,
      price: _parsePrice(
        json['price'] ?? detail?['price'] ?? detail?['price_product'],
      ),
      categoryId: _parseCategoryId(json['id_categoria']),
      options: const [
        ProductOption(
          name: 'Tamanho',
          options: ['PP', 'P', 'M', 'G', 'GG', 'XG'],
        ),
        ProductOption(name: 'Cor', options: ['Preto', 'Branco']),
      ],
      colorVariations: colorVars,
    );
  }

  List<String> getGalleryForColor(String colorName) {
    final variation = colorVariations.firstWhere(
      (v) => v.colorName.toLowerCase() == colorName.toLowerCase(),
      orElse: () => colorVariations.isNotEmpty
          ? colorVariations.first
          : const ColorVariation(colorName: '', galleryImages: []),
    );
    return variation.galleryImages.isNotEmpty
        ? variation.galleryImages
        : galleryUrls;
  }

  static List<String> _parseGalleryUrls(
    Map<String, dynamic> json,
    Map<String, dynamic>? detail,
  ) {
    final rawGallery =
        json['galleryUrls'] ??
        json['gallery'] ??
        json['gallery_image'] ??
        json['gallery_Image'] ??
        detail?['gallery'] ??
        detail?['gallery_image'] ??
        detail?['gallery_Image'];

    if (rawGallery is String && rawGallery.isNotEmpty) {
      return [rawGallery];
    }

    if (rawGallery is List) {
      return rawGallery
          .map((e) => e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
    }

    // Fallbacks to potential image fields
    final candidates = <String>[];
    final main =
        json['path_image'] ??
        json['image'] ??
        detail?['main_image'] ??
        detail?['mainImage'];
    if (main is String && main.isNotEmpty) candidates.add(main);

    return candidates;
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

  static List<ColorVariation> _parseColorVariations(Object? details) {
    if (details is! List || details.isEmpty) return [];

    final variations = <ColorVariation>[];
    for (final item in details) {
      if (item is! Map<String, dynamic>) continue;

      final colorName = _extractColorName(item);
      final gallery = _parseDetailGallery(item);

      variations.add(
        ColorVariation(
          colorName: colorName,
          colorHex: _extractColorHex(item),
          galleryImages: gallery,
        ),
      );
    }

    return variations;
  }

  static String _extractColorName(Map<String, dynamic> detail) {
    final titleProduct = (detail['title_product'] ?? '')
        .toString()
        .toLowerCase();
    if (titleProduct.contains('branca') || titleProduct.contains('white')) {
      return 'Branco';
    }
    if (titleProduct.contains('preto') || titleProduct.contains('black')) {
      return 'Preto';
    }
    return 'Padrão';
  }

  static String? _extractColorHex(Map<String, dynamic> detail) {
    final colorName = _extractColorName(detail);
    if (colorName == 'Branco') return '#FFFFFF';
    if (colorName == 'Preto') return '#0A0A0A';
    return null;
  }

  static List<String> _parseDetailGallery(Map<String, dynamic> detail) {
    final rawGallery =
        detail['gallery_image'] ?? detail['gallery_Image'] ?? detail['gallery'];

    if (rawGallery is String && rawGallery.isNotEmpty) {
      return [rawGallery];
    }

    if (rawGallery is List) {
      return rawGallery
          .map((e) => e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
    }

    final mainImage = detail['main_image'];
    if (mainImage is String && mainImage.isNotEmpty) {
      return [mainImage];
    }

    return [];
  }

  static double _parsePrice(Object? value) {
    if (value == null) return 0.0;

    if (value is num) return value.toDouble();

    if (value is String) {
      // Remove currency symbols and spaces
      final cleaned = value.replaceAll(RegExp(r'[^0-9,\.]'), '').trim();

      if (cleaned.isEmpty) return 0.0;

      // Handle formats like 1.234,56 (Brazilian) -> 1234.56
      if (cleaned.contains(',') && cleaned.contains('.')) {
        final normalized = cleaned.replaceAll('.', '').replaceAll(',', '.');
        return double.tryParse(normalized) ?? 0.0;
      }

      // Handle comma as decimal separator
      if (cleaned.contains(',') && !cleaned.contains('.')) {
        final normalized = cleaned.replaceAll(',', '.');
        return double.tryParse(normalized) ?? 0.0;
      }

      return double.tryParse(cleaned) ?? 0.0;
    }

    return 0.0;
  }

  static int _parseCategoryId(Object? value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
