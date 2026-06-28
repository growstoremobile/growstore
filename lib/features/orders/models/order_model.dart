import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growstore/features/address/models/address_model.dart';
import 'package:growstore/features/cart/models/cart_item_model.dart';

class OrderModel {
  final String id;
  final AddressModel address;
  final List<CartItemModel> items;
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.address,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
  return {
    'address': address.toJson(),
    'items': items.map((e) => e.toJson()).toList(),
    'subtotal': subtotal,
    'shipping': shipping,
    'discount': discount,
    'total': total,
    'createdAt': Timestamp.fromDate(createdAt),
  };
}

factory OrderModel.fromJson(
  Map<String, dynamic> json,
  String id,
) {
  return OrderModel(
    id: id,
    address: AddressModel.fromJson(
      json['address'],
      json['address']['id'] ?? '',
    ),
    items: (json['items'] as List)
        .map(
          (item) => CartItemModel.fromJson(item),
        )
        .toList(),
    subtotal: (json['subtotal'] as num).toDouble(),
    shipping: (json['shipping'] as num).toDouble(),
    discount: (json['discount'] as num).toDouble(),
    total: (json['total'] as num).toDouble(),
    createdAt:
        (json['createdAt'] as Timestamp).toDate(),
  );
}


}