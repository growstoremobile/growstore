import 'package:growstore/features/address/models/address_model.dart';
import 'package:growstore/features/address/stores/address_store.dart';
import 'package:growstore/features/checkout/storage/checkout_storage.dart';
import 'package:mobx/mobx.dart';

part 'checkout_store.g.dart';

class CheckoutStore = CheckoutStoreBase with _$CheckoutStore;

abstract class CheckoutStoreBase with Store {
  CheckoutStoreBase(
    this._addressStore,
    this._storage,
  );

  final AddressStore _addressStore;
  final CheckoutStorage _storage;

  @observable
  String? selectedAddressId;

  @computed
  AddressModel? get selectedAddress {
    try {
      return _addressStore.addresses.firstWhere(
        (a) => a.id == selectedAddressId,
      );
    } catch (_) {
      return null;
    }
  }

  @action
  Future<void> initialize() async {
    final savedId = await _storage.getSelectedAddress();

    if (savedId != null &&
        _addressStore.addresses.any((a) => a.id == savedId)) {
      selectedAddressId = savedId;
      return;
    }

    final defaultAddress = _addressStore.defaultAddress;

    if (defaultAddress != null) {
      selectedAddressId = defaultAddress.id;
    }
  }

  @action
  Future<void> selectAddress(String id) async {
    selectedAddressId = id;
    await _storage.saveSelectedAddress(id);
  }
}