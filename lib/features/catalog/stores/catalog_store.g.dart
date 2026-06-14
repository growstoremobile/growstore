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

  late final _$_catalogAtom =
      Atom(name: 'CatalogStoreBase._catalog', context: context);

  @override
  ObservableList<CatalogModel> get _catalog {
    _$_catalogAtom.reportRead();
    return super._catalog;
  }

  @override
  set _catalog(ObservableList<CatalogModel> value) {
    _$_catalogAtom.reportWrite(value, super._catalog, () {
      super._catalog = value;
    });
  }

  late final _$loadCatalogAsyncAction =
      AsyncAction('CatalogStoreBase.loadCatalog', context: context);

  @override
  Future<void> loadCatalog() {
    return _$loadCatalogAsyncAction.run(() => super.loadCatalog());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
