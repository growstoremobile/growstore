class CartItemModel {
  final String id;
  final String name;
  final String variation;
  final double price;
  final String imageUrl;
  final int quantity;

  const CartItemModel({
    required this.id,
    required this.name,
    required this.variation,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  // Preço total da linha (preço unitário x quantidade)
  double get totalPrice => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'variation': variation,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      name: json['name'],
      variation: json['variation'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
    );
  }

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      id: id,
      name: name,
      variation: variation,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}
