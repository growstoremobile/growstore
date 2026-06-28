import 'package:hive/hive.dart';
import 'package:growstore/shared/utils/price_utils.dart';

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
    final detail = _firstProductDetail(json['product_details']);

    return FavorityModel(
      id: _parseId(json['id']),
      titleProduct:
          (json['title'] ?? json['title_product'] ?? json['name'] ?? '')
              .toString(),
      priceProduct: parseGrowPrice(
        json['price'] ?? json['price_product'] ?? detail?['price'],
      ),
      pathImage:
          (json['image'] ??
                  json['imagem'] ??
                  json['path_image'] ??
                  json['imageUrl'] ??
                  detail?['main_image'])
              ?.toString(),
    );
  }

  static int _parseId(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
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
