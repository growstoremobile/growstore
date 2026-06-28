import 'package:growstore/features/profile/models/address_model.dart';
import 'package:hive/hive.dart';

class AddressRepository {
  AddressRepository({Box? box}) : _box = box ?? Hive.box(boxName);

  static const boxName = 'addresses';
  static const _addressesKey = 'addresses_list';

  final Box _box;

  Future<List<AddressModel>> getAddresses() async {
    final rawAddresses = _box.get(_addressesKey);

    if (rawAddresses is! List) return [];

    return rawAddresses.whereType<Map>().map(AddressModel.fromJson).toList();
  }

  Future<AddressModel?> getDefaultAddress() async {
    final addresses = await getAddresses();

    for (final address in addresses) {
      if (address.isDefault) return address;
    }

    return addresses.isEmpty ? null : addresses.first;
  }

  Future<void> saveAddress(AddressModel address) async {
    final addresses = await getAddresses();
    final index = addresses.indexWhere((item) => item.id == address.id);
    final shouldBeDefault = address.isDefault || addresses.isEmpty;
    final nextAddress = address.copyWith(isDefault: shouldBeDefault);

    final nextAddresses = addresses
        .map((item) => shouldBeDefault ? item.copyWith(isDefault: false) : item)
        .toList();

    if (index >= 0) {
      nextAddresses[index] = nextAddress;
    } else {
      nextAddresses.add(nextAddress);
    }

    await _saveAll(nextAddresses);
  }

  Future<void> deleteAddress(String id) async {
    final addresses = await getAddresses();
    AddressModel? removedAddress;

    for (final address in addresses) {
      if (address.id == id) {
        removedAddress = address;
        break;
      }
    }

    final nextAddresses = addresses.where((item) => item.id != id).toList();

    if (removedAddress?.isDefault == true && nextAddresses.isNotEmpty) {
      nextAddresses[0] = nextAddresses[0].copyWith(isDefault: true);
    }

    await _saveAll(nextAddresses);
  }

  Future<void> setDefaultAddress(String id) async {
    final addresses = await getAddresses();

    await _saveAll(
      addresses.map((address) {
        return address.copyWith(isDefault: address.id == id);
      }).toList(),
    );
  }

  Future<void> _saveAll(List<AddressModel> addresses) async {
    await _box.put(
      _addressesKey,
      addresses.map((address) => address.toJson()).toList(),
    );
  }
}
