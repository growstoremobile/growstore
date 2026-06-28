// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_categories_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailCategoriesStore on DetailCategoriesStoreBase, Store {
  Computed<List<HomeProductModel>>? _$filteredProductsComputed;

  @override
  List<HomeProductModel> get filteredProducts => (_$filteredProductsComputed ??=
          Computed<List<HomeProductModel>>(() => super.filteredProducts,
              name: 'DetailCategoriesStoreBase.filteredProducts'))
      .value;

  late final _$isLoadingAtom =
      Atom(name: 'DetailCategoriesStoreBase.isLoading', context: context);

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

  late final _$searchAtom =
      Atom(name: 'DetailCategoriesStoreBase.search', context: context);

  @override
  String get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'DetailCategoriesStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$productsAtom =
      Atom(name: 'DetailCategoriesStoreBase.products', context: context);

  @override
  ObservableList<HomeProductModel> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<HomeProductModel> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$loadProductsAsyncAction =
      AsyncAction('DetailCategoriesStoreBase.loadProducts', context: context);

  @override
  Future<void> loadProducts() {
    return _$loadProductsAsyncAction.run(() => super.loadProducts());
  }

  late final _$DetailCategoriesStoreBaseActionController =
      ActionController(name: 'DetailCategoriesStoreBase', context: context);

  @override
  void setSearch(String value) {
    final _$actionInfo = _$DetailCategoriesStoreBaseActionController
        .startAction(name: 'DetailCategoriesStoreBase.setSearch');
    try {
      return super.setSearch(value);
    } finally {
      _$DetailCategoriesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$DetailCategoriesStoreBaseActionController
        .startAction(name: 'DetailCategoriesStoreBase.clearError');
    try {
      return super.clearError();
    } finally {
      _$DetailCategoriesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
search: ${search},
errorMessage: ${errorMessage},
products: ${products},
filteredProducts: ${filteredProducts}
    ''';
  }
}
