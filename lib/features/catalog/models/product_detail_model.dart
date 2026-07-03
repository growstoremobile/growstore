import 'product_option_model.dart';

class ColorVariation {
  final String colorName;
  final String? colorHex;
  final String imageUrl;

  const ColorVariation({
    required this.colorName,
    this.colorHex,
    required this.imageUrl,
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
    final detail = _extractDetail(json['product_details']);
    final gallery = _parseGalleryUrls(json, detail);
    final colorVars = _parseColorVariations(
      gallery,
      json['title_product'] ?? json['title'] ?? '',
    );

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

  /// Retorna a imagem para a cor solicitada.
  /// Busca por correspondência exata primeiro, depois parcial.
  /// Se não encontrar, retorna a imagem principal.
  String getImageForColor(String colorName) {
    if (colorVariations.isEmpty) return mainImageUrl;

    final normalizedRequest = colorName.toLowerCase().trim();

    final exact = colorVariations.where(
      (v) => v.colorName.toLowerCase().trim() == normalizedRequest,
    );
    if (exact.isNotEmpty) return exact.first.imageUrl;

    final partial = colorVariations.where(
      (v) =>
          v.colorName.toLowerCase().contains(normalizedRequest) ||
          normalizedRequest.contains(v.colorName.toLowerCase()),
    );
    if (partial.isNotEmpty) return partial.first.imageUrl;

    return mainImageUrl;
  }

  /// Mantido para compatibilidade — retorna lista com a imagem da cor
  List<String> getGalleryForColor(String colorName) {
    final image = getImageForColor(colorName);
    return [image];
  }

  static Map<String, dynamic>? _extractDetail(Object? details) {
    if (details is Map) {
      return Map<String, dynamic>.from(details);
    }
    if (details is List && details.isNotEmpty && details.first is Map) {
      return Map<String, dynamic>.from(details.first as Map);
    }
    return null;
  }

  /// Parseia gallery_image que pode ser String ou List
  static List<String> _parseGalleryUrls(
    Map<String, dynamic> json,
    Map<String, dynamic>? detail,
  ) {
    // Tenta pegar do gallery_image do detail primeiro
    if (detail != null) {
      final raw =
          detail['gallery_image'] ??
          detail['gallery_Image'] ??
          detail['gallery'];
      if (raw is List) {
        final urls = raw
            .map((e) => e?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList();
        if (urls.isNotEmpty) return urls;
      }
      if (raw is String && raw.isNotEmpty) return [raw];
    }

    // Fallback: imagem principal
    final main =
        json['path_image'] ?? json['image'] ?? detail?['main_image'] ?? '';
    if (main is String && main.isNotEmpty) return [main];

    return [];
  }

  /// Cria variações de cor baseado nas URLs da galeria.
  /// A convenção do banco é:
  ///   gallery_image[0] = cor padrão (preta)
  ///   gallery_image[1] = cor alternativa (branca)
  /// O nome da cor é detectado pela URL da imagem.
  static List<ColorVariation> _parseColorVariations(
    List<String> galleryUrls,
    String productName,
  ) {
    if (galleryUrls.length < 2) return [];

    final variations = <ColorVariation>[];

    for (final url in galleryUrls) {
      final normalized = url.toLowerCase();
      String colorName;
      String colorHex;

      if (normalized.contains('branca') ||
          normalized.contains('branco') ||
          normalized.contains('white')) {
        colorName = 'Branco';
        colorHex = '#FFFFFF';
      } else if (normalized.contains('preto') ||
          normalized.contains('preta') ||
          normalized.contains('black')) {
        colorName = 'Preto';
        colorHex = '#0A0A0A';
      } else {
        // Primeira imagem sem identificador = cor padrão (preta)
        colorName = variations.isEmpty ? 'Preto' : 'Branco';
        colorHex = variations.isEmpty ? '#0A0A0A' : '#FFFFFF';
      }

      variations.add(
        ColorVariation(colorName: colorName, colorHex: colorHex, imageUrl: url),
      );
    }

    return variations;
  }

  static double _parsePrice(Object? value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();

    if (value is String) {
      final cleaned = value.replaceAll(RegExp(r'[^0-9,\.]'), '').trim();
      if (cleaned.isEmpty) return 0.0;

      if (cleaned.contains(',') && cleaned.contains('.')) {
        final normalized = cleaned.replaceAll('.', '').replaceAll(',', '.');
        return double.tryParse(normalized) ?? 0.0;
      }

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
