// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CatalogStore on CatalogStoreBase, Store {
  Computed<List<CatalogModel>>? _$filteredCatalogsComputed;

  @override
  List<CatalogModel> get filteredCatalogs => (_$filteredCatalogsComputed ??=
          Computed<List<CatalogModel>>(() => super.filteredCatalogs,
              name: 'CatalogStoreBase.filteredCatalogs'))
      .value;

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

  late final _$_catalogsAtom =
      Atom(name: 'CatalogStoreBase._catalogs', context: context);

  @override
  ObservableList<CatalogModel> get _catalogs {
    _$_catalogsAtom.reportRead();
    return super._catalogs;
  }

  @override
  set _catalogs(ObservableList<CatalogModel> value) {
    _$_catalogsAtom.reportWrite(value, super._catalogs, () {
      super._catalogs = value;
    });
  }

  late final _$searchAtom =
      Atom(name: 'CatalogStoreBase.search', context: context);

  @override
  String? get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String? value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'CatalogStoreBase.errorMessage', context: context);

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

  late final _$loadCatalogAsyncAction =
      AsyncAction('CatalogStoreBase.loadCatalog', context: context);

  @override
  Future<void> loadCatalog() {
    return _$loadCatalogAsyncAction.run(() => super.loadCatalog());
  }

  late final _$CatalogStoreBaseActionController =
      ActionController(name: 'CatalogStoreBase', context: context);

  @override
  void setSearch(String? text) {
    final _$actionInfo = _$CatalogStoreBaseActionController.startAction(
        name: 'CatalogStoreBase.setSearch');
    try {
      return super.setSearch(text);
    } finally {
      _$CatalogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$CatalogStoreBaseActionController.startAction(
        name: 'CatalogStoreBase.clearError');
    try {
      return super.clearError();
    } finally {
      _$CatalogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
errorMessage: ${errorMessage},
filteredCatalogs: ${filteredCatalogs}
    ''';
  }
}
