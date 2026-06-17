import 'package:growstore/features/cart/models/cart_item_model.dart';

abstract class CartService {
  Future<List<CartItemModel>> getCartItems();
}

class CartServiceMock implements CartService {
  @override
  Future<List<CartItemModel>> getCartItems() async {
    // Itens iniciais do carrinho (dados simulados enquanto não há API/catálogo)
    return const [
      CartItemModel(
        id: '1',
        name: 'DEV Backpack Pro',
        variation: 'Cor: Matte Black / Tamanho: Único',
        price: 549.00,
        imageUrl: 'https://loremflickr.com/400/400/backpack?lock=10',
        quantity: 1,
      ),
      CartItemModel(
        id: '2',
        name: 'Grow Mug .TS',
        variation: 'Cor: Glossy Black / 350ml',
        price: 178.00,
        imageUrl: 'https://loremflickr.com/400/400/coffee,mug?lock=20',
        quantity: 1,
      ),
      CartItemModel(
        id: '3',
        name: 'Stationery Kit V2',
        variation: 'Notebook + 2x Pen / Jetblack',
        price: 120.00,
        imageUrl: 'https://loremflickr.com/400/400/notebook,stationery?lock=30',
        quantity: 2,
      ),
    ];
  }
}
