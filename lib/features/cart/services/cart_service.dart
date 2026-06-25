import 'package:growstore/features/cart/models/cart_item_model.dart';

abstract class CartService {
  Future<List<CartItemModel>> getCartItems();
}

class CartServiceMock implements CartService {
  @override
  Future<List<CartItemModel>> getCartItems() async {
    return const [];
  }
}
