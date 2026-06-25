import 'package:get_it/get_it.dart';
import 'package:growstore/features/catalog/services/product_detail_service.dart';
import 'package:growstore/features/catalog/repositories/product_detail_repository.dart';
import 'package:growstore/features/catalog/stores/product_detail_store.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton<ProductDetailService>(ProductDetailService());
  getIt.registerSingleton<ProductDetailRepository>(
    ProductDetailRepository(service: getIt.get<ProductDetailService>()),
  );
  getIt.registerFactory<ProductDetailStore>(
    () => ProductDetailStore(repository: getIt.get<ProductDetailRepository>()),
  );
}
