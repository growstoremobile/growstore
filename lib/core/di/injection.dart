import 'package:get_it/get_it.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/categories/repositories/categories_repository.dart';
import 'package:growstore/features/categories/stores/categories_store.dart';
import 'package:growstore/features/categories/stores/detail_categories_store.dart';
import 'package:growstore/features/catalog/repositories/product_detail_repository.dart';
import 'package:growstore/features/catalog/services/product_detail_service.dart';
import 'package:growstore/features/catalog/stores/product_detail_store.dart';
import 'package:growstore/shared/products/services/product_service.dart';

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
