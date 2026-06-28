import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/orders/models/order_item_model.dart';
import 'package:growstore/features/orders/models/order_model.dart';
import 'package:growstore/features/orders/models/order_status.dart';
import 'package:hive/hive.dart';

class OrderRepository {
  OrderRepository({Box? box}) : _box = box ?? Hive.box(boxName);

  static const boxName = 'orders';
  static const _ordersKey = 'orders_list';

  final Box _box;

  Future<List<OrderModel>> getOrders() async {
    final rawOrders = _box.get(_ordersKey);

    if (rawOrders is! List) return [];

    final orders = rawOrders.whereType<Map>().map(OrderModel.fromJson).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return orders;
  }

  Future<OrderModel?> getOrderById(String id) async {
    final orders = await getOrders();

    for (final order in orders) {
      if (order.id == id) return order;
    }

    return null;
  }

  Future<OrderModel> createOrder({
    required List<CartItemModel> cartItems,
    required double subtotal,
    required double shipping,
    required double discount,
    required double total,
    String? shippingAddress,
  }) async {
    final now = DateTime.now();
    final order = OrderModel(
      id: now.millisecondsSinceEpoch.toString(),
      createdAt: now,
      status: OrderStatus.pending,
      items: cartItems.map(OrderItemModel.fromCartItem).toList(),
      subtotal: subtotal,
      shipping: shipping,
      discount: discount,
      total: total,
      shippingAddress: shippingAddress,
    );

    final orders = await getOrders();
    final nextOrders = [order, ...orders];

    await _box.put(
      _ordersKey,
      nextOrders.map((order) => order.toJson()).toList(),
    );

    return order;
  }
}
