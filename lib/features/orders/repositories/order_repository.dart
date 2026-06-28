import 'package:growstore/features/orders/models/order_model.dart';
import 'package:growstore/features/orders/services/order_service.dart';

class OrderRepository {
  final OrderService _service;

  OrderRepository(this._service);

  Future<OrderModel> createOrder(OrderModel order) {
    return _service.createOrder(order);
  }

  Future<List<OrderModel>> getOrders() {
    return _service.getOrders();
  }
}
