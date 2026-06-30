import 'package:flutter_test/flutter_test.dart';
import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';

void main() {
  test('cart totals follow quantity changes', () {
    final store = CartStore();
    const bottle = CartItemModel(
      id: '4',
      name: 'Garrafa termica',
      variation: 'Garrafas',
      price: 39.90,
      imageUrl: 'assets/images/figma_home_product_bottle.png',
    );
    const stickers = CartItemModel(
      id: '5',
      name: 'Kit Adesivos',
      variation: 'Adesivos',
      price: 5.90,
      imageUrl: 'assets/images/figma_home_product_stickers.png',
    );

    store.addItem(bottle);
    store.addItem(bottle);
    store.addItem(stickers);

    expect(store.items.length, 2);
    expect(store.totalItems, 3);
    expect(store.items.first.quantity, 2);
    expect(store.items.first.totalPrice, 79.80);
    expect(store.subtotal, 85.70);
    expect(store.total, 120.70);

    store.decrementQuantity(store.items.first);

    expect(store.totalItems, 2);
    expect(store.items.first.quantity, 1);
    expect(store.subtotal, 45.80);
    expect(store.total, 80.80);
  });

  test('decrement removes an item when its quantity reaches zero', () {
    final store = CartStore();
    const bottle = CartItemModel(
      id: '4',
      name: 'Garrafa termica',
      variation: 'Garrafas',
      price: 39.90,
      imageUrl: 'assets/images/figma_home_product_bottle.png',
    );

    store.addItem(bottle);
    store.decrementQuantity(bottle);

    expect(store.items, isEmpty);
    expect(store.totalItems, 0);
    expect(store.subtotal, 0);
    expect(store.total, 0);
  });
}
