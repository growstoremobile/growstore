import 'package:growstore/shared/utils/price_utils.dart';

class HomeProductModel {
  const HomeProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.priceValue,
    required this.asset,
  });

  final int id;
  final String name;
  final String category;
  final String price;
  final double priceValue;
  final String asset;

  factory HomeProductModel.fromJson(Map<String, dynamic> json) {
    final priceValue = parseGrowPrice(json['price'] ?? json['price_product']);
    final rawCategory = json['categorias'];
    final category = rawCategory is Map
        ? rawCategory['name_category']
        : json['category'] ?? json['categoria'];

    return HomeProductModel(
      id: _parseId(json['id']),
      name:
          (json['title'] ?? json['title_product'] ?? json['name'] ?? 'Produto')
              .toString(),
      category: (category ?? 'Produto').toString(),
      price: _formatPrice(priceValue),
      priceValue: priceValue,
      asset:
          (json['image'] ??
                  json['imageUrl'] ??
                  json['path_image'] ??
                  json['asset'] ??
                  '')
              .toString(),
    );
  }

  bool get hasRemoteImage => asset.startsWith('http');

  static int _parseId(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static String _formatPrice(double value) {
    return formatGrowCurrency(value);
  }
}
