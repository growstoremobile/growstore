import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/catalog/models/product_detail_model.dart';
import 'package:growstore/features/catalog/repositories/product_detail_repository.dart';
import 'package:mobx/mobx.dart';

part 'product_detail_store.g.dart';

class ProductDetailStore = ProductDetailStoreBase with _$ProductDetailStore;

abstract class ProductDetailStoreBase with Store {
  final ProductDetailRepository _repository;
  final CartStore _cartStore;

  ProductDetailStoreBase({
    required ProductDetailRepository repository,
    required CartStore cartStore,
  }) : _repository = repository,
       _cartStore = cartStore;

  @observable
  ProductDetailsModel? product;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  String? selectedSize;

  @observable
  String? selectedColor;

  @observable
  int quantity = 1;

  @action
  void selectSize(String size) => selectedSize = size;

  @action
  void selectColor(String color) => selectedColor = color;

  @action
  void incrementQuantity() {
    quantity++;
  }

  @action
  void decrementQuantity() {
    if (quantity <= 1) return;

    quantity--;
  }

  bool get hasValidSelection {
    return product != null &&
        selectedSize?.trim().isNotEmpty == true &&
        selectedColor?.trim().isNotEmpty == true;
  }

  @action
  Future<void> loadProduct(String id) async {
    try {
      isLoading = true;
      error = null;
      selectedSize = null;
      selectedColor = null;
      quantity = 1;
      product = await _repository.getProductById(id);
    } catch (_) {
      error = 'Erro ao carregar produto.';
    } finally {
      isLoading = false;
    }
  }

  @action
  bool addToCart() {
    final currentProduct = product;
    final size = selectedSize?.trim();
    final color = selectedColor?.trim();

    if (currentProduct == null ||
        size == null ||
        size.isEmpty ||
        color == null ||
        color.isEmpty) {
      return false;
    }

    _cartStore.addItem(
      CartItemModel(
        id: currentProduct.uid,
        name: currentProduct.name,
        variation: '$color / $size',
        price: currentProduct.price,
        imageUrl: currentProduct.mainImageUrl,
        quantity: quantity,
      ),
    );

    return true;
  }
}
