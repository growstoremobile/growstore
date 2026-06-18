// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on CartStoreBase, Store {
  Computed<double>? _$subtotalComputed;

  @override
  double get subtotal =>
      (_$subtotalComputed ??= Computed<double>(() => super.subtotal,
              name: 'CartStoreBase.subtotal'))
          .value;
  Computed<int>? _$totalItemsComputed;

  @override
  int get totalItems =>
      (_$totalItemsComputed ??= Computed<int>(() => super.totalItems,
              name: 'CartStoreBase.totalItems'))
          .value;
  Computed<double>? _$shippingComputed;

  @override
  double get shipping =>
      (_$shippingComputed ??= Computed<double>(() => super.shipping,
              name: 'CartStoreBase.shipping'))
          .value;
  Computed<double>? _$discountComputed;

  @override
  double get discount =>
      (_$discountComputed ??= Computed<double>(() => super.discount,
              name: 'CartStoreBase.discount'))
          .value;
  Computed<double>? _$totalComputed;

  @override
  double get total => (_$totalComputed ??=
          Computed<double>(() => super.total, name: 'CartStoreBase.total'))
      .value;

  late final _$itemsAtom = Atom(name: 'CartStoreBase.items', context: context);

  @override
  ObservableList<CartItemModel> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<CartItemModel> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$_isLoadingAtom =
      Atom(name: 'CartStoreBase._isLoading', context: context);

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

  late final _$errorAtom = Atom(name: 'CartStoreBase.error', context: context);

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

  late final _$appliedCouponAtom =
      Atom(name: 'CartStoreBase.appliedCoupon', context: context);

  @override
  String? get appliedCoupon {
    _$appliedCouponAtom.reportRead();
    return super.appliedCoupon;
  }

  @override
  set appliedCoupon(String? value) {
    _$appliedCouponAtom.reportWrite(value, super.appliedCoupon, () {
      super.appliedCoupon = value;
    });
  }

  late final _$couponErrorAtom =
      Atom(name: 'CartStoreBase.couponError', context: context);

  @override
  String? get couponError {
    _$couponErrorAtom.reportRead();
    return super.couponError;
  }

  @override
  set couponError(String? value) {
    _$couponErrorAtom.reportWrite(value, super.couponError, () {
      super.couponError = value;
    });
  }

  late final _$lastAddedItemAtom =
      Atom(name: 'CartStoreBase.lastAddedItem', context: context);

  @override
  CartItemModel? get lastAddedItem {
    _$lastAddedItemAtom.reportRead();
    return super.lastAddedItem;
  }

  @override
  set lastAddedItem(CartItemModel? value) {
    _$lastAddedItemAtom.reportWrite(value, super.lastAddedItem, () {
      super.lastAddedItem = value;
    });
  }

  late final _$loadCartAsyncAction =
      AsyncAction('CartStoreBase.loadCart', context: context);

  @override
  Future<void> loadCart() {
    return _$loadCartAsyncAction.run(() => super.loadCart());
  }

  late final _$CartStoreBaseActionController =
      ActionController(name: 'CartStoreBase', context: context);

  @override
  void addItem(CartItemModel item) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.addItem');
    try {
      return super.addItem(item);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementQuantity(CartItemModel item) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.incrementQuantity');
    try {
      return super.incrementQuantity(item);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity(CartItemModel item) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.decrementQuantity');
    try {
      return super.decrementQuantity(item);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeItem(CartItemModel item) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.removeItem');
    try {
      return super.removeItem(item);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void applyCoupon(String code) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.applyCoupon');
    try {
      return super.applyCoupon(code);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeCoupon() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.removeCoupon');
    try {
      return super.removeCoupon();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCart() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.clearCart');
    try {
      return super.clearCart();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
error: ${error},
appliedCoupon: ${appliedCoupon},
couponError: ${couponError},
lastAddedItem: ${lastAddedItem},
subtotal: ${subtotal},
totalItems: ${totalItems},
shipping: ${shipping},
discount: ${discount},
total: ${total}
    ''';
  }
}
