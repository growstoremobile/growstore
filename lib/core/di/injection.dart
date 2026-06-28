import 'package:get_it/get_it.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/catalog/repositories/product_detail_repository.dart';
import 'package:growstore/features/catalog/services/product_detail_service.dart';
import 'package:growstore/features/catalog/stores/product_detail_store.dart';

Future<void> setupDependencies() async {
  final locator = GetIt.I;

  if (!locator.isRegistered<CartStore>()) {
    locator.registerSingleton<CartStore>(CartStore());
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
}
