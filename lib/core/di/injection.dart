import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/categories/repositories/categories_repository.dart';
import 'package:growstore/features/categories/stores/categories_store.dart';
import 'package:growstore/features/categories/stores/detail_categories_store.dart';
import 'package:growstore/features/catalog/repositories/product_detail_repository.dart';
import 'package:growstore/features/catalog/services/product_detail_service.dart';
import 'package:growstore/features/catalog/stores/product_detail_store.dart';
import 'package:growstore/features/address/repositories/address_repository.dart';
import 'package:growstore/features/address/services/address_firestore_service.dart';
import 'package:growstore/features/address/services/address_service.dart';
import 'package:growstore/features/address/services/cep_service.dart';
import 'package:growstore/features/address/stores/address_store.dart';
import 'package:growstore/features/cart/repositories/cart_repository.dart';
import 'package:growstore/features/checkout/storage/checkout_storage.dart';
import 'package:growstore/features/checkout/stores/checkout_store.dart';
import 'package:growstore/features/orders/repositories/order_repository.dart';
import 'package:growstore/features/orders/services/order_firestore_service.dart';
import 'package:growstore/features/orders/services/order_service.dart';
import 'package:growstore/features/orders/stores/order_store.dart';
import 'package:growstore/shared/products/services/product_service.dart';

Future<void> setupDependencies() async {
  final getIt = GetIt.instance;
  final locator = GetIt.I;

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

  //Cart

  if (!locator.isRegistered<CartStore>()) {
    getIt.registerLazySingleton<CartStore>(
      () => CartStore(getIt<CartRepository>()),
    );
  }

  if (!locator.isRegistered<ProductDetailService>()) {
    locator.registerSingleton<ProductDetailService>(ProductDetailService());
  }

  if (!locator.isRegistered<ProductDetailRepository>()) {
    locator.registerSingleton<ProductDetailRepository>(
      ProductDetailRepository(service: locator<ProductDetailService>()),
    );
  }

  if (!locator.isRegistered<ProductDetailStore>()) {
    locator.registerFactory<ProductDetailStore>(
      () => ProductDetailStore(
        repository: locator<ProductDetailRepository>(),
        cartStore: locator<CartStore>(),
      ),
    );
  }

  if (!locator.isRegistered<ProductService>()) {
    locator.registerLazySingleton<ProductService>(() => ProductService());
  }

  if (!locator.isRegistered<CategoriesRepository>()) {
    locator.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepository(productService: locator<ProductService>()),
    );
  }

  if (!locator.isRegistered<CategoryStore>()) {
    locator.registerFactory<CategoryStore>(
      () => CategoryStore(repository: locator<CategoriesRepository>()),
    );
  }

  if (!locator.isRegistered<DetailCategoriesStore>()) {
    locator.registerFactoryParam<DetailCategoriesStore, int, void>(
      (categoryId, _) => DetailCategoriesStore(
        repository: locator<CategoriesRepository>(),
        categoryId: categoryId,
      ),
    );
  }
}
