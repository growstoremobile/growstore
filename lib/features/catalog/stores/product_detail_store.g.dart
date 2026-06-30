// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductDetailStore on ProductDetailStoreBase, Store {
  late final _$productAtom =
      Atom(name: 'ProductDetailStoreBase.product', context: context);

  @override
  ProductDetailsModel? get product {
    _$productAtom.reportRead();
    return super.product;
  }

  @override
  set product(ProductDetailsModel? value) {
    _$productAtom.reportWrite(value, super.product, () {
      super.product = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ProductDetailStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'ProductDetailStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$selectedSizeAtom =
      Atom(name: 'ProductDetailStoreBase.selectedSize', context: context);

  @override
  String? get selectedSize {
    _$selectedSizeAtom.reportRead();
    return super.selectedSize;
  }

  @override
  set selectedSize(String? value) {
    _$selectedSizeAtom.reportWrite(value, super.selectedSize, () {
      super.selectedSize = value;
    });
  }

  late final _$selectedColorAtom =
      Atom(name: 'ProductDetailStoreBase.selectedColor', context: context);

  @override
  String? get selectedColor {
    _$selectedColorAtom.reportRead();
    return super.selectedColor;
  }

  @override
  set selectedColor(String? value) {
    _$selectedColorAtom.reportWrite(value, super.selectedColor, () {
      super.selectedColor = value;
    });
  }

  late final _$quantityAtom =
      Atom(name: 'ProductDetailStoreBase.quantity', context: context);

  @override
  int get quantity {
    _$quantityAtom.reportRead();
    return super.quantity;
  }

  @override
  set quantity(int value) {
    _$quantityAtom.reportWrite(value, super.quantity, () {
      super.quantity = value;
    });
  }

  late final _$loadProductAsyncAction =
      AsyncAction('ProductDetailStoreBase.loadProduct', context: context);

  @override
  Future<void> loadProduct(String productId) {
    return _$loadProductAsyncAction.run(() => super.loadProduct(productId));
  }

  late final _$ProductDetailStoreBaseActionController =
      ActionController(name: 'ProductDetailStoreBase', context: context);

  @override
  void selectSize(String size) {
    final _$actionInfo = _$ProductDetailStoreBaseActionController.startAction(
        name: 'ProductDetailStoreBase.selectSize');
    try {
      return super.selectSize(size);
    } finally {
      _$ProductDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectColor(String colorHex) {
    final _$actionInfo = _$ProductDetailStoreBaseActionController.startAction(
        name: 'ProductDetailStoreBase.selectColor');
    try {
      return super.selectColor(colorHex);
    } finally {
      _$ProductDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementQuantity() {
    final _$actionInfo = _$ProductDetailStoreBaseActionController.startAction(
        name: 'ProductDetailStoreBase.incrementQuantity');
    try {
      return super.incrementQuantity();
    } finally {
      _$ProductDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity() {
    final _$actionInfo = _$ProductDetailStoreBaseActionController.startAction(
        name: 'ProductDetailStoreBase.decrementQuantity');
    try {
      return super.decrementQuantity();
    } finally {
      _$ProductDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementQuantity() {
    final _$actionInfo = _$ProductDetailStoreBaseActionController.startAction(
        name: 'ProductDetailStoreBase.incrementQuantity');
    try {
      return super.incrementQuantity();
    } finally {
      _$ProductDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity() {
    final _$actionInfo = _$ProductDetailStoreBaseActionController.startAction(
        name: 'ProductDetailStoreBase.decrementQuantity');
    try {
      return super.decrementQuantity();
    } finally {
      _$ProductDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool addToCart() {
    final _$actionInfo = _$ProductDetailStoreBaseActionController.startAction(
        name: 'ProductDetailStoreBase.addToCart');
    try {
      return super.addToCart();
    } finally {
      _$ProductDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
product: ${product},
isLoading: ${isLoading},
error: ${error},
selectedSize: ${selectedSize},
selectedColor: ${selectedColor},
quantity: ${quantity}
    ''';
  }
}
