// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressStore on AddressStoreBase, Store {
  Computed<AddressModel?>? _$defaultAddressComputed;

  @override
  AddressModel? get defaultAddress => (_$defaultAddressComputed ??=
          Computed<AddressModel?>(() => super.defaultAddress,
              name: 'AddressStoreBase.defaultAddress'))
      .value;

  late final _$addressesAtom =
      Atom(name: 'AddressStoreBase.addresses', context: context);

  @override
  ObservableList<AddressModel> get addresses {
    _$addressesAtom.reportRead();
    return super.addresses;
  }

  @override
  set addresses(ObservableList<AddressModel> value) {
    _$addressesAtom.reportWrite(value, super.addresses, () {
      super.addresses = value;
    });
  }

  late final _$_isLoadingAtom =
      Atom(name: 'AddressStoreBase._isLoading', context: context);

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

  late final _$errorAtom =
      Atom(name: 'AddressStoreBase.error', context: context);

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

  late final _$searchCepAsyncAction =
      AsyncAction('AddressStoreBase.searchCep', context: context);

  @override
  Future<CepModel?> searchCep(String cep) {
    return _$searchCepAsyncAction.run(() => super.searchCep(cep));
  }

  late final _$loadAddressesAsyncAction =
      AsyncAction('AddressStoreBase.loadAddresses', context: context);

  @override
  Future<void> loadAddresses() {
    return _$loadAddressesAsyncAction.run(() => super.loadAddresses());
  }

  late final _$addAddressAsyncAction =
      AsyncAction('AddressStoreBase.addAddress', context: context);

  @override
  Future<void> addAddress(AddressModel address) {
    return _$addAddressAsyncAction.run(() => super.addAddress(address));
  }

  late final _$removeAddressAsyncAction =
      AsyncAction('AddressStoreBase.removeAddress', context: context);

  @override
  Future<void> removeAddress(String id) {
    return _$removeAddressAsyncAction.run(() => super.removeAddress(id));
  }

  late final _$setDefaultAddressAsyncAction =
      AsyncAction('AddressStoreBase.setDefaultAddress', context: context);

  @override
  Future<void> setDefaultAddress(String id) {
    return _$setDefaultAddressAsyncAction
        .run(() => super.setDefaultAddress(id));
  }

  @override
  String toString() {
    return '''
addresses: ${addresses},
error: ${error},
defaultAddress: ${defaultAddress}
    ''';
  }
}
