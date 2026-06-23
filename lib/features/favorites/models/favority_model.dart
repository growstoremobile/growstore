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
          json['title'] ??
          json['title'] ??
          '', // Ajuste as chaves conforme seu banco
      priceProduct: (json['price'] ?? json['price'] ?? 0.0).toDouble(),
      pathImage: json['image'] ?? json['imagem'],
    );
  }
}
