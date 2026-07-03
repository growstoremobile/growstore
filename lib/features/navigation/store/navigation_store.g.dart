// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NavigationStore on NavigationStoreBase, Store {
  late final _$currentIndexAtom =
      Atom(name: 'NavigationStoreBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$NavigationStoreBaseActionController =
      ActionController(name: 'NavigationStoreBase', context: context);

  @override
  void changePage(int index) {
    final _$actionInfo = _$NavigationStoreBaseActionController.startAction(
        name: 'NavigationStoreBase.changePage');
    try {
      return super.changePage(index);
    } finally {
      _$NavigationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex}
    ''';
  }
}
