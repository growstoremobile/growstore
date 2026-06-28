import 'package:hive/hive.dart';

class CheckoutStorage {
  static const _boxName = 'checkout';
  static const _selectedAddressKey = 'selected_address';

  Future<void> saveSelectedAddress(String id) async {
    final box = await Hive.openBox(_boxName);

    await box.put(_selectedAddressKey, id);
  }

  Future<String?> getSelectedAddress() async {
    final box = await Hive.openBox(_boxName);

    return box.get(_selectedAddressKey);
  }

  Future<void> clearSelectedAddress() async {
    final box = await Hive.openBox(_boxName);

    await box.delete(_selectedAddressKey);
  }
}
