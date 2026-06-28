import 'package:hive/hive.dart';

part 'favority_model.g.dart';

@HiveType(typeId: 1)
class FavorityModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String titleProduct;
  @HiveField(2)
  final double priceProduct;
  @HiveField(3)
  final String? pathImage;

  FavorityModel({
    required this.id,
    required this.titleProduct,
    required this.priceProduct,
    this.pathImage,
  });

  // Converte os dados brutos do Supabase em FavorityModel
  factory FavorityModel.fromJson(Map<String, dynamic> json) {
    return FavorityModel(
      id: json['id'] as int,
      titleProduct:
          (json['title'] ?? json['title_product'] ?? json['name'] ?? '')
              .toString(),
      priceProduct: _parsePrice(json['price'] ?? json['price_product']),
      pathImage:
          (json['image'] ??
                  json['imagem'] ??
                  json['path_image'] ??
                  json['imageUrl'])
              ?.toString(),
    );
  }

  static double _parsePrice(Object? value) {
    if (value is num) return value.toDouble();

    final normalized = value?.toString().replaceAll(',', '.') ?? '';
    return double.tryParse(normalized) ?? 0;
  }
}
