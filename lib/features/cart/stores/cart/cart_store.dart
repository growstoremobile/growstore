import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/repositories/cart_repository.dart';
import 'package:mobx/mobx.dart';

part 'cart_store.g.dart';

class CartStore = CartStoreBase with _$CartStore;

abstract class CartStoreBase with Store {
  CartStoreBase([CartRepository? repository])
    : _repository = repository ?? CartRepository();

  final CartRepository _repository;

  // Cupom válido (mock) e o desconto que ele concede
  static const String _validCoupon = 'GROW10';
  static const double _discountRate = 0.10;

  // Frete fixo (mock)
  static const double _shippingFee = 35.00;

  @observable
  ObservableList<CartItemModel> items = ObservableList<CartItemModel>();

  @observable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @observable
  String? error;

  // Cupom aplicado no momento (null quando nenhum) e mensagem de erro do cupom
  @observable
  String? appliedCoupon;

  @observable
  String? couponError;

  // Subtotal atualizado automaticamente (soma de preço x quantidade)
  @computed
  double get subtotal =>
      items.fold(0, (total, item) => total + item.totalPrice);

  // Quantidade total de itens, para o contador da tela
  @computed
  int get totalItems => items.fold(0, (total, item) => total + item.quantity);

  // Frete fixo, exibido quando há itens no carrinho
  @computed
  double get shipping => items.isEmpty ? 0 : _shippingFee;

  // Desconto de 10% quando o cupom GROW10 está aplicado
  @computed
  double get discount => appliedCoupon != null ? subtotal * _discountRate : 0;

  // Total final: subtotal - desconto + frete
  @computed
  double get total => subtotal - discount + shipping;

  @action
  Future<void> loadCart() async {
    try {
      error = null;
      _isLoading = true;

      // Simula o tempo de resposta da API
      await Future.delayed(const Duration(seconds: 2));

      final result = await _repository.getCartItems();
      items = ObservableList<CartItemModel>.of(result);
    } on CustomError catch (e) {
      error = e.message;
    } finally {
      _isLoading = false;
    }
  }

  @action
  void incrementQuantity(CartItemModel item) {
    final index = items.indexWhere((e) => e.id == item.id);
    if (index == -1) return;

    final current = items[index];
    items[index] = current.copyWith(quantity: current.quantity + 1);
  }

  @action
  void decrementQuantity(CartItemModel item) {
    final index = items.indexWhere((e) => e.id == item.id);
    if (index == -1) return;

    final current = items[index];
    // A quantidade mínima é 1; remover é feito pelo gesto de arrastar
    if (current.quantity <= 1) return;
    items[index] = current.copyWith(quantity: current.quantity - 1);
  }

  @action
  void removeItem(CartItemModel item) {
    items.removeWhere((e) => e.id == item.id);
  }

  @action
  void applyCoupon(String code) {
    final normalized = code.trim().toUpperCase();

    if (normalized.isEmpty) {
      couponError = 'Informe um cupom';
      return;
    }

    if (normalized == _validCoupon) {
      appliedCoupon = normalized;
      couponError = null;
    } else {
      appliedCoupon = null;
      couponError = 'Cupom inválido';
    }
  }

  @action
  void removeCoupon() {
    appliedCoupon = null;
    couponError = null;
  }
}
