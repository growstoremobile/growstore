import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:growstore/features/address/repositories/address_repository.dart';
import 'package:growstore/features/address/services/address_firestore_service.dart';
import 'package:growstore/features/address/services/address_service.dart';
import 'package:growstore/features/address/services/cep_service.dart';
import 'package:growstore/features/address/stores/address_store.dart';
import 'package:growstore/features/cart/repositories/cart_repository.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/checkout/storage/checkout_storage.dart';
import 'package:growstore/features/checkout/stores/checkout_store.dart';
import 'package:growstore/features/orders/repositories/order_repository.dart';
import 'package:growstore/features/orders/services/order_firestore_service.dart';
import 'package:growstore/features/orders/services/order_service.dart';
import 'package:growstore/features/orders/stores/order_store.dart';

void setupDependencies() {
  final getIt = GetIt.instance;

  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  //Firebase
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //Checkout
  getIt.registerLazySingleton<CheckoutStore>(
    () => CheckoutStore(getIt<AddressStore>(), getIt<CheckoutStorage>()),
  );
  getIt.registerLazySingleton<CheckoutStorage>(() => CheckoutStorage());

  ///Adddress
  getIt.registerLazySingleton<CepService>(() => ViaCepService(getIt<Dio>()));
  getIt.registerLazySingleton<AddressService>(
    () => AddressFirestoreService(
      getIt<FirebaseFirestore>(),
      getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerLazySingleton<AddressRepository>(
    () => AddressRepository(getIt<AddressService>()),
  );
  getIt.registerLazySingleton<AddressStore>(
    () => AddressStore(getIt<AddressRepository>(), getIt<CepService>()),
  );

  //Cart
  getIt.registerLazySingleton<CartRepository>(() => CartRepository());
  getIt.registerLazySingleton<CartStore>(
    () => CartStore(getIt<CartRepository>()),
  );
  // Orders
  getIt.registerLazySingleton<OrderService>(
    () => OrderFirestoreService(
      getIt<FirebaseFirestore>(),
      getIt<FirebaseAuth>(),
    ),
  );

  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepository(getIt<OrderService>()),
  );
  getIt.registerLazySingleton<OrderStore>(
    () => OrderStore(getIt<OrderRepository>()),
  );
}
