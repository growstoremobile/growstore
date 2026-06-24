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
}
