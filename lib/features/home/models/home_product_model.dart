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
    final priceValue = _parsePrice(json['price']);

    return HomeProductModel(
      id: _parseId(json['id']),
      name: (json['title'] ?? json['name'] ?? 'Produto').toString(),
      category: (json['category'] ?? 'Produto').toString(),
      price: _formatPrice(priceValue),
      priceValue: priceValue,
      asset: (json['image'] ?? json['imageUrl'] ?? json['asset'] ?? '')
          .toString(),
    );
  }

  bool get hasRemoteImage => asset.startsWith('http');

  static int _parseId(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _parsePrice(Object? value) {
    if (value is num) return value.toDouble();

    final normalized = value?.toString().replaceAll(',', '.') ?? '';
    return double.tryParse(normalized) ?? 0;
  }

  static String _formatPrice(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
