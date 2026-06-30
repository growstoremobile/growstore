import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growstore/features/address/models/address_model.dart';
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
    required this.address,
  });

  final String id;
  final DateTime createdAt;
  final OrderStatus status;

  final List<OrderItemModel> items;
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final AddressModel address;

 
  final String? shippingAddress;

  int get totalItems => items.fold(0, (total, item) => total + item.quantity);

 
  factory OrderModel.fromJson(Map<dynamic, dynamic> json, String id) {
    final rawItems = json['items'];

    return OrderModel(
      id: id,
      createdAt: _parseDate(json['createdAt']),
      status: OrderStatus.fromString(json['status']),
      address: AddressModel.fromJson(
        json['address'],
        json['address']['id'] ?? '',
      ),
      items: rawItems is List
          ? rawItems
                .whereType<Map>()
                .map((e) => OrderItemModel.fromJson(e))
                .toList()
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
      'createdAt': Timestamp.fromDate(createdAt),
      'address': address.toJson(),
      'status': status.label,
      'items': items.map((e) => e.toJson()).toList(),
      'subtotal': subtotal,
      'shipping': shipping,
      'discount': discount,
      'total': total,
      'shippingAddress': shippingAddress,
    };
  }

  
  static DateTime _parseDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
    return DateTime.now();
  }
}
