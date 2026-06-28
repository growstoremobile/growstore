import 'package:growstore/features/orders/models/order_item_model.dart';
import 'package:growstore/features/orders/models/order_status.dart';
import 'package:growstore/shared/utils/price_utils.dart';

class OrderModel {
  const OrderModel({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
    this.shippingAddress,
  });

  final String id;
  final DateTime createdAt;
  final OrderStatus status;
  final List<OrderItemModel> items;
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final String? shippingAddress;

  int get totalItems => items.fold(0, (total, item) => total + item.quantity);

  factory OrderModel.fromJson(Map<dynamic, dynamic> json) {
    final rawItems = json['items'];

    return OrderModel(
      id: json['id']?.toString() ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      status: OrderStatus.fromString(json['status']),
      items: rawItems is List
          ? rawItems.whereType<Map>().map(OrderItemModel.fromJson).toList()
          : const [],
      subtotal: parseGrowPrice(json['subtotal']),
      shipping: parseGrowPrice(json['shipping']),
      discount: parseGrowPrice(json['discount']),
      total: parseGrowPrice(json['total']),
      shippingAddress: json['shippingAddress']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'status': status.label,
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'shipping': shipping,
      'discount': discount,
      'total': total,
      'shippingAddress': shippingAddress,
    };
  }
}
