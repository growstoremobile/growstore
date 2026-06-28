import 'package:growstore/features/orders/models/order_model.dart';
import 'package:growstore/features/orders/repositories/order_repository.dart';
import 'package:mobx/mobx.dart';

part 'order_store.g.dart';

class OrderStore = OrderStoreBase with _$OrderStore;

abstract class OrderStoreBase with Store {
  OrderStoreBase(this._repository);

  final OrderRepository _repository;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  OrderModel? lastOrder;

  @observable
  ObservableList<OrderModel> orders =
      ObservableList<OrderModel>();

  @action
  Future<void> createOrder(OrderModel order) async {
    try {
      error = null;
      isLoading = true;

      final createdOrder =
          await _repository.createOrder(order);

      lastOrder = createdOrder;

      orders.insert(0, createdOrder);
    } catch (e) {
      error = 'Erro ao finalizar pedido.';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadOrders() async {
    try {
      error = null;
      isLoading = true;

      final result = await _repository.getOrders();

      orders = ObservableList.of(result);
    } catch (e) {
      error = 'Erro ao carregar pedidos.';
    } finally {
      isLoading = false;
    }
  }
}