import 'package:growstore/features/orders/models/order_model.dart';

abstract class OrderService {
  Future<OrderModel> createOrder(OrderModel order);
  Future<List<OrderModel>> getOrders();
  Future<OrderModel?> getOrderById(String id);
}

/*class OrderServiceMock implements OrderService {
  static final List<OrderModel> _orders = [];

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    _orders.add(order);
    return order;
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    return _orders;
  }
}
*/