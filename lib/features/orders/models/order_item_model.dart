import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/shared/utils/price_utils.dart';

class OrderItemModel {
  const OrderItemModel({
    required this.id,
    required this.name,
    required this.variation,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  final String id;
  final String name;
  final String variation;
  final double price;
  final String imageUrl;
  final int quantity;

  double get total => price * quantity;

  factory OrderItemModel.fromCartItem(CartItemModel item) {
    return OrderItemModel(
      id: item.id,
      name: item.name,
      variation: item.variation,
      price: item.price,
      imageUrl: item.imageUrl,
      quantity: item.quantity,
    );
  }

  factory OrderItemModel.fromJson(Map<dynamic, dynamic> json) {
    return OrderItemModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Produto',
      variation: json['variation']?.toString() ?? '',
      price: parseGrowPrice(json['price']),
      imageUrl: json['imageUrl']?.toString() ?? '',
      quantity: _parseInt(json['quantity']),
    );
  }

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

  static int _parseInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 1;
  }
}
