// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckoutStore on CheckoutStoreBase, Store {
  Computed<AddressModel?>? _$selectedAddressComputed;

  @override
  AddressModel? get selectedAddress => (_$selectedAddressComputed ??=
          Computed<AddressModel?>(() => super.selectedAddress,
              name: 'CheckoutStoreBase.selectedAddress'))
      .value;

  late final _$selectedAddressIdAtom =
      Atom(name: 'CheckoutStoreBase.selectedAddressId', context: context);

  @override
  String? get selectedAddressId {
    _$selectedAddressIdAtom.reportRead();
    return super.selectedAddressId;
  }

  @override
  set selectedAddressId(String? value) {
    _$selectedAddressIdAtom.reportWrite(value, super.selectedAddressId, () {
      super.selectedAddressId = value;
    });
  }

  late final _$initializeAsyncAction =
      AsyncAction('CheckoutStoreBase.initialize', context: context);

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$selectAddressAsyncAction =
      AsyncAction('CheckoutStoreBase.selectAddress', context: context);

  @override
  Future<void> selectAddress(String id) {
    return _$selectAddressAsyncAction.run(() => super.selectAddress(id));
  }

  @override
  String toString() {
    return '''
selectedAddressId: ${selectedAddressId},
selectedAddress: ${selectedAddress}
    ''';
  }
}
