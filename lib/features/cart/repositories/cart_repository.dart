import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/services/cart_service.dart';

class CartRepository {
  final CartService _service;

  CartRepository([CartService? service])
    : _service = service ?? CartServiceMock();

  Future<List<CartItemModel>> getCartItems() {
    return _service.getCartItems();
  }
}
