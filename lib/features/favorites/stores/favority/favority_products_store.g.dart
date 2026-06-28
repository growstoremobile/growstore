// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favority_products_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavorityProductsStore on FavorityProductsStoreBase, Store {
  late final _$favoritiesAtom =
      Atom(name: 'FavorityProductsStoreBase.favorities', context: context);

  @override
  ObservableList<Map<String, dynamic>> get favorities {
    _$favoritiesAtom.reportRead();
    return super.favorities;
  }

  @override
  set favorities(ObservableList<Map<String, dynamic>> value) {
    _$favoritiesAtom.reportWrite(value, super.favorities, () {
      super.favorities = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'FavorityProductsStoreBase.isLoading', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: 'FavorityProductsStoreBase.errorMessage', context: context);

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

  late final _$getFavoritiesAsyncAction =
      AsyncAction('FavorityProductsStoreBase.getFavorities', context: context);

  @override
  Future<void> getFavorities() {
    return _$getFavoritiesAsyncAction.run(() => super.getFavorities());
  }

  late final _$toggleFavorityAsyncAction =
      AsyncAction('FavorityProductsStoreBase.toggleFavority', context: context);

  @override
  Future<void> toggleFavority(Map<String, dynamic> product) {
    return _$toggleFavorityAsyncAction.run(() => super.toggleFavority(product));
  }

  @override
  String toString() {
    return '''
favorities: ${favorities},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
