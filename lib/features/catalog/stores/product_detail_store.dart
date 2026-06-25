import 'package:get_it/get_it.dart';
import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/catalog/models/product_detail_model.dart';
import 'package:growstore/features/catalog/repositories/product_detail_repository.dart';
import 'package:mobx/mobx.dart';

part 'product_detail_store.g.dart';

class ProductDetailStore = _ProductDetailStore with _$ProductDetailStore;

abstract class _ProductDetailStore with Store {
  final ProductDetailRepository _repository;

  _ProductDetailStore({required ProductDetailRepository repository})
    : _repository = repository;

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

  @action
  void selectSize(String size) => selectedSize = size;

  @action
  void selectColor(String color) => selectedColor = color;

  bool get hasValidSelection => selectedSize != null && selectedColor != null;

  @action
  Future<void> loadProduct(String id) async {
    try {
      isLoading = true;
      error = null;
      product = await _repository.getProductById(id);
    } catch (e) {
      error = 'Erro ao carregar produto.';
    } finally {
      isLoading = false;
    }
  }

  @action
  bool addToCart() {
    if (!hasValidSelection || product == null) return false;

    final cartStore = GetIt.I.get<CartStore>();
    cartStore.addItem(
      CartItemModel(
        id: product!.uid,
        name: product!.name,
        variation: '$selectedColor / $selectedSize',
        price: product!.price,
        imageUrl: product!.mainImageUrl,
      ),
    );
    return true;
  }
}
