import 'package:growstore/features/address/models/address_model.dart';

abstract class AddressService {
  Future<List<AddressModel>> getAddresses();
  Future<void> saveAddress(AddressModel address);
  Future<void> removeAddress(String id);
  Future<void> setDefaultAddress(String id);
}

class AddressServiceMock implements AddressService {
  static final List<AddressModel> _addresses = [];

  @override
  Future<List<AddressModel>> getAddresses() async {
    return _addresses;
  }

  @override
  Future<void> saveAddress(AddressModel address) async {
    _addresses.add(address);
  }

  @override
  Future<void> removeAddress(String id) async {
    _addresses.removeWhere((a) => a.id == id);
  }

  @override
  Future<void> setDefaultAddress(String id) async {
    for (int i = 0; i < _addresses.length; i++) {
      _addresses[i] = _addresses[i].copyWith(isDefault: _addresses[i].id == id);
    }
  }
}
