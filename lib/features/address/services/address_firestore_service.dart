import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:growstore/features/address/models/address_model.dart';
import 'address_service.dart';

class AddressFirestoreService implements AddressService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AddressFirestoreService(this.firestore, this.auth);

  String get _uid {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception("Usuário não autenticado. Operação não permitida.");
    }
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _collection =>
      firestore.collection('users').doc(_uid).collection('addresses');

  @override
  Future<List<AddressModel>> getAddresses() async {
    final snapshot = await _collection.get();

    return snapshot.docs.map((doc) {
      return AddressModel.fromJson(doc.data(), doc.id);
    }).toList();
  }

  @override
  Future<void> saveAddress(AddressModel address) async {
    await _collection.doc(address.id).set(address.toJson());
  }

  @override
  Future<void> removeAddress(String id) async {
    await _collection.doc(id).delete();
  }

  @override
  Future<void> setDefaultAddress(String id) async {
    final snapshot = await _collection.get();

    final batch = firestore.batch();

    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {'isDefault': doc.id == id});
    }

    await batch.commit();
  }
}
