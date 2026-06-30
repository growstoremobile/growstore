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

  @observable
  bool hasLoaded = false;

  // -------------------------
  // CREATE ORDER
  // -------------------------
  @action
  Future<void> createOrder(OrderModel order) async {
    try {
      isLoading = true;
      error = null;

      final createdOrder = await _repository.createOrder(order);

      lastOrder = createdOrder;

      orders.insert(0, createdOrder);
    } catch (e) {
      error = 'Erro ao finalizar pedido.';
    } finally {
      isLoading = false;
    }
  }

  // -------------------------
  // LOAD ORDERS (Firestore)
  // -------------------------
  @action
  Future<void> loadOrders() async {
    if (hasLoaded) return;

    try {
      isLoading = true;
      error = null;

      final result = await _repository.getOrders();

      orders = ObservableList<OrderModel>.of(result);

      hasLoaded = true;
    } catch (e) {
      error = 'Erro ao carregar pedidos.';
    } finally {
      isLoading = false;
    }
  }

  // -------------------------
  // GET BY ID
  // -------------------------
  OrderModel? getOrderById(String id) {
    try {
      return orders.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  // -------------------------
  // REFRESH
  // -------------------------
  @action
  Future<void> refreshOrders() async {
    try {
      isLoading = true;
      error = null;

      final result = await _repository.getOrders();

      orders = ObservableList<OrderModel>.of(result);
    } catch (e) {
      error = 'Erro ao atualizar pedidos.';
    } finally {
      isLoading = false;
    }
  }
}