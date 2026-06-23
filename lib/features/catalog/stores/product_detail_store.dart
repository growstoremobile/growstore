import 'package:mobx/mobx.dart';

part 'product_detail_store.g.dart';

class ProductDetailStore = _ProductDetailStore with _$ProductDetailStore;

abstract class _ProductDetailStore with Store {
  @observable
  String? selectedSize;

  @observable
  String? selectedColor;

  @action
  void selectSize(String size) {
    selectedSize = size;
  }

  @action
  void selectColor(String color) {
    selectedColor = color;
  }

  // Vamos usar isso no Item 6
  bool get hasValidSelection {
    return selectedSize != null && selectedColor != null;
  }
}
