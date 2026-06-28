// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryStore on CategoryStoreBase, Store {
  Computed<List<CategoryModel>>? _$filteredCategoriesComputed;

  @override
  List<CategoryModel> get filteredCategories =>
      (_$filteredCategoriesComputed ??= Computed<List<CategoryModel>>(
              () => super.filteredCategories,
              name: 'CategoryStoreBase.filteredCategories'))
          .value;

  late final _$_isLoadingAtom =
      Atom(name: 'CategoryStoreBase._isLoading', context: context);

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

  late final _$_categoriesAtom =
      Atom(name: 'CategoryStoreBase._categories', context: context);

  @override
  ObservableList<CategoryModel> get _categories {
    _$_categoriesAtom.reportRead();
    return super._categories;
  }

  @override
  set _categories(ObservableList<CategoryModel> value) {
    _$_categoriesAtom.reportWrite(value, super._categories, () {
      super._categories = value;
    });
  }

  late final _$searchAtom =
      Atom(name: 'CategoryStoreBase.search', context: context);

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
      Atom(name: 'CategoryStoreBase.errorMessage', context: context);

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

  late final _$loadCategoriesAsyncAction =
      AsyncAction('CategoryStoreBase.loadCategories', context: context);

  @override
  Future<void> loadCategories() {
    return _$loadCategoriesAsyncAction.run(() => super.loadCategories());
  }

  late final _$CategoryStoreBaseActionController =
      ActionController(name: 'CategoryStoreBase', context: context);

  @override
  void setSearch(String? text) {
    final _$actionInfo = _$CategoryStoreBaseActionController.startAction(
        name: 'CategoryStoreBase.setSearch');
    try {
      return super.setSearch(text);
    } finally {
      _$CategoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$CategoryStoreBaseActionController.startAction(
        name: 'CategoryStoreBase.clearError');
    try {
      return super.clearError();
    } finally {
      _$CategoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
errorMessage: ${errorMessage},
filteredCategories: ${filteredCategories}
    ''';
  }
}
