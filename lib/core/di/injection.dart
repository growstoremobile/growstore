import 'package:get_it/get_it.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/catalog/repositories/product_detail_repository.dart';
import 'package:growstore/features/catalog/services/product_detail_service.dart';
import 'package:growstore/features/catalog/stores/product_detail_store.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  if (!getIt.isRegistered<CartStore>()) {
    getIt.registerSingleton<CartStore>(CartStore());
  }

  if (!getIt.isRegistered<ProductDetailService>()) {
    getIt.registerSingleton<ProductDetailService>(ProductDetailService());
  }

  if (!getIt.isRegistered<ProductDetailRepository>()) {
    getIt.registerSingleton<ProductDetailRepository>(
      ProductDetailRepository(service: getIt<ProductDetailService>()),
    );
  }

  if (!getIt.isRegistered<ProductDetailStore>()) {
    getIt.registerFactory<ProductDetailStore>(
      () => ProductDetailStore(
        repository: getIt<ProductDetailRepository>(),
        cartStore: getIt<CartStore>(),
      ),
    );
  }
}
