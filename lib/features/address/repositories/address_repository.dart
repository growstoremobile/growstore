import 'package:growstore/features/address/models/address_model.dart';
import 'package:growstore/features/address/services/address_service.dart';

class AddressRepository {
  final AddressService _service;

  AddressRepository([AddressService? service])
    : _service = service ?? AddressServiceMock();

  Future<List<AddressModel>> getAddresses() {
    return _service.getAddresses();
  }

  Future<void> saveAddress(AddressModel address) {
    return _service.saveAddress(address);
  }

  Future<void> removeAddress(String id) {
    return _service.removeAddress(id);
  }

  Future<void> setDefaultAddress(String id) {
    return _service.setDefaultAddress(id);
  }
}
