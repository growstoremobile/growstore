// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderStore on OrderStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'OrderStoreBase.isLoading', context: context);

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

  late final _$errorAtom = Atom(name: 'OrderStoreBase.error', context: context);

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

  late final _$lastOrderAtom =
      Atom(name: 'OrderStoreBase.lastOrder', context: context);

  @override
  OrderModel? get lastOrder {
    _$lastOrderAtom.reportRead();
    return super.lastOrder;
  }

  @override
  set lastOrder(OrderModel? value) {
    _$lastOrderAtom.reportWrite(value, super.lastOrder, () {
      super.lastOrder = value;
    });
  }

  late final _$ordersAtom =
      Atom(name: 'OrderStoreBase.orders', context: context);

  @override
  ObservableList<OrderModel> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(ObservableList<OrderModel> value) {
    _$ordersAtom.reportWrite(value, super.orders, () {
      super.orders = value;
    });
  }

  late final _$hasLoadedAtom =
      Atom(name: 'OrderStoreBase.hasLoaded', context: context);

  @override
  bool get hasLoaded {
    _$hasLoadedAtom.reportRead();
    return super.hasLoaded;
  }

  @override
  set hasLoaded(bool value) {
    _$hasLoadedAtom.reportWrite(value, super.hasLoaded, () {
      super.hasLoaded = value;
    });
  }

  late final _$createOrderAsyncAction =
      AsyncAction('OrderStoreBase.createOrder', context: context);

  @override
  Future<void> createOrder(OrderModel order) {
    return _$createOrderAsyncAction.run(() => super.createOrder(order));
  }

  late final _$loadOrdersAsyncAction =
      AsyncAction('OrderStoreBase.loadOrders', context: context);

  @override
  Future<void> loadOrders() {
    return _$loadOrdersAsyncAction.run(() => super.loadOrders());
  }

  late final _$refreshOrdersAsyncAction =
      AsyncAction('OrderStoreBase.refreshOrders', context: context);

  @override
  Future<void> refreshOrders() {
    return _$refreshOrdersAsyncAction.run(() => super.refreshOrders());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
error: ${error},
lastOrder: ${lastOrder},
orders: ${orders},
hasLoaded: ${hasLoaded}
    ''';
  }
}
