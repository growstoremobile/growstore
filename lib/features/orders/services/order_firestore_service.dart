import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:growstore/features/orders/models/order_model.dart';
import 'package:growstore/features/orders/services/order_service.dart';

class OrderFirestoreService implements OrderService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  OrderFirestoreService(this.firestore, this.auth);

  String get _uid {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _collection =>
      firestore.collection('users').doc(_uid).collection('orders');

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    await _collection.doc(order.id).set(order.toJson());

    return order;
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final snapshot = await _collection
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return OrderModel.fromJson(doc.data(), doc.id);
    }).toList();
  }
}
