// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CatalogStore on CatalogStoreBase, Store {
  late final _$_isLoadingAtom =
      Atom(name: 'CatalogStoreBase._isLoading', context: context);

  @override
  bool get _isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$_productsAtom =
      Atom(name: 'CatalogStoreBase._products', context: context);

  @override
  ObservableList<ProductModel> get _products {
    _$_productsAtom.reportRead();
    return super._products;
  }

  @override
  set _products(ObservableList<ProductModel> value) {
    _$_productsAtom.reportWrite(value, super._products, () {
      super._products = value;
    });
  }

  late final _$loadProductsAsyncAction =
      AsyncAction('CatalogStoreBase.loadProducts', context: context);

  @override
  Future<void> loadProducts() {
    return _$loadProductsAsyncAction.run(() => super.loadProducts());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
