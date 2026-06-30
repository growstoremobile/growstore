import 'package:flutter_test/flutter_test.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/catalog/models/product_detail_model.dart';
import 'package:growstore/features/catalog/repositories/product_detail_repository.dart';
import 'package:growstore/features/catalog/stores/product_detail_store.dart';

void main() {
  test('addToCart adds selected product to the injected cart store', () {
    final cartStore = CartStore();
    final store = ProductDetailStore(
      repository: _FakeProductDetailRepository(),
      cartStore: cartStore,
    );

    store.product = const ProductDetailsModel(
      uid: '13',
      name: 'Camiseta preta',
      description: 'Camiseta Grow Store',
      mainImageUrl: 'assets/images/figma_home_product_tshirt.png',
      galleryUrls: ['assets/images/figma_home_product_tshirt.png'],
      price: 79.90,
    );
    store.selectColor('Preto');
    store.selectSize('M');
    store.incrementQuantity();

    expect(store.addToCart(), isTrue);
    expect(cartStore.items, hasLength(1));
    expect(cartStore.items.single.id, '13');
    expect(cartStore.items.single.variation, 'Preto / M');
    expect(cartStore.items.single.quantity, 2);
    expect(cartStore.totalItems, 2);
  });

  test('addToCart does not add without size and color selection', () {
    final cartStore = CartStore();
    final store = ProductDetailStore(
      repository: _FakeProductDetailRepository(),
      cartStore: cartStore,
    );

    store.product = const ProductDetailsModel(
      uid: '13',
      name: 'Camiseta preta',
      description: 'Camiseta Grow Store',
      mainImageUrl: 'assets/images/figma_home_product_tshirt.png',
      galleryUrls: ['assets/images/figma_home_product_tshirt.png'],
      price: 79.90,
    );

    expect(store.addToCart(), isFalse);
    expect(cartStore.items, isEmpty);
  });

  test('ProductDetailsModel parses numeric and formatted price values', () {
    final numericPrice = ProductDetailsModel.fromJson({
      'id': 1,
      'title': 'Produto',
      'price': 79.90,
      'image': 'assets/images/figma_home_product_tshirt.png',
    });
    final formattedPrice = ProductDetailsModel.fromJson({
      'id': 2,
      'title': 'Produto',
      'price': 'R\$ 1.234,56',
      'image': 'assets/images/figma_home_product_tshirt.png',
    });

    expect(numericPrice.price, 79.90);
    expect(formattedPrice.price, 1234.56);
  });

  test('ProductDetailsModel parses Supabase product column names', () {
    final product = ProductDetailsModel.fromJson({
      'id': 8,
      'title_product': 'Camiseta Dev Growdev',
      'path_image': 'https://example.com/camiseta.png',
    });

    expect(product.name, 'Camiseta Dev Growdev');
    expect(product.mainImageUrl, 'https://example.com/camiseta.png');
    expect(product.galleryUrls, ['https://example.com/camiseta.png']);
  });

  test('ProductDetailsModel parses price and image from product details', () {
    final product = ProductDetailsModel.fromJson({
      'id': 8,
      'title_product': 'Camiseta Dev Growdev',
      'product_details': [
        {
          'price': 'R\$ 129,90',
          'main_image': 'https://example.com/detail.png',
          'description': 'Detalhe vindo do Supabase',
        },
      ],
    });

    expect(product.price, 129.90);
    expect(product.mainImageUrl, 'https://example.com/detail.png');
    expect(product.description, 'Detalhe vindo do Supabase');
  });
}

class _FakeProductDetailRepository implements ProductDetailRepository {
  @override
  Future<ProductDetailsModel> getProductById(String id) {
    throw UnimplementedError();
  }
}
