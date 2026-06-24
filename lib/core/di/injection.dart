import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

// Favorites - Depois tirar comentarios
import 'package:growstore/features/favorites/services/favority_service.dart';
import 'package:growstore/features/favorites/repositories/favority_repository.dart';
import 'package:growstore/features/favorites/stores/favority/favority_products_store.dart';

// Catalog - Depois tirar comentarios
import 'package:growstore/features/catalog/services/product_detail_service.dart';
import 'package:growstore/features/catalog/repositories/product_detail_repository.dart';
import 'package:growstore/features/catalog/stores/product_detail_store.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // ── Favorites ──
  final favorityBox = await Hive.openBox('favorities');

  getIt.registerSingleton<FavorityService>(FavorityService());

  getIt.registerSingleton<FavorityRepository>(
    FavorityRepository(
      boxFavoritiesProducts: favorityBox,
      favoriteService: getIt.get<FavorityService>(),
    ),
  );

  getIt.registerSingleton<FavorityProductsStore>(FavorityProductsStore());

  // ── Catalog ──
  getIt.registerSingleton<ProductDetailService>(ProductDetailService());

  getIt.registerSingleton<ProductDetailRepository>(
    ProductDetailRepository(service: getIt.get<ProductDetailService>()),
  );

  getIt.registerFactory<ProductDetailStore>(
    () => ProductDetailStore(repository: getIt.get<ProductDetailRepository>()),
  );
}
