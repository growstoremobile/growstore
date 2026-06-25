// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductDetailStore on _ProductDetailStore, Store {
  late final _$productAtom =
      Atom(name: '_ProductDetailStore.product', context: context);

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
      Atom(name: '_ProductDetailStore.isLoading', context: context);

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
      Atom(name: '_ProductDetailStore.error', context: context);

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
      Atom(name: '_ProductDetailStore.selectedSize', context: context);

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
      Atom(name: '_ProductDetailStore.selectedColor', context: context);

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

  late final _$loadProductAsyncAction =
      AsyncAction('_ProductDetailStore.loadProduct', context: context);

  @override
  Future<void> loadProduct(String id) {
    return _$loadProductAsyncAction.run(() => super.loadProduct(id));
  }

  late final _$_ProductDetailStoreActionController =
      ActionController(name: '_ProductDetailStore', context: context);

  @override
  void selectSize(String size) {
    final _$actionInfo = _$_ProductDetailStoreActionController.startAction(
        name: '_ProductDetailStore.selectSize');
    try {
      return super.selectSize(size);
    } finally {
      _$_ProductDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectColor(String color) {
    final _$actionInfo = _$_ProductDetailStoreActionController.startAction(
        name: '_ProductDetailStore.selectColor');
    try {
      return super.selectColor(color);
    } finally {
      _$_ProductDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool addToCart() {
    final _$actionInfo = _$_ProductDetailStoreActionController.startAction(
        name: '_ProductDetailStore.addToCart');
    try {
      return super.addToCart();
    } finally {
      _$_ProductDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
product: ${product},
isLoading: ${isLoading},
error: ${error},
selectedSize: ${selectedSize},
selectedColor: ${selectedColor}
    ''';
  }
}
