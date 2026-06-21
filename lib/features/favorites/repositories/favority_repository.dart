import 'package:growstore/features/favorites/services/favority_service.dart';
import 'package:hive/hive.dart';

class FavorityRepository {
  final Box boxFavoritiesProducts;
  final FavoriteService _favoriteService;

  FavorityRepository({
    required this.boxFavoritiesProducts,
    required FavoriteService favoriteService,
  }) : _favoriteService = favoriteService;

  // 1. Pega apenas a lista bruta de IDs salvos no dispositivo
  List<int> getSavedIds() {
    final List<dynamic> ids = boxFavoritiesProducts.get(
      "favorities_ids",
      defaultValue: <dynamic>[],
    );
    return ids.cast<int>();
  }

  // 2. Orquestra: Pega os IDs locais e busca os detalhes completos no Supabase
  Future<List<Map<String, dynamic>>> getAllFavorities() async {
    final List<int> ids = getSavedIds();
    return await _favoriteService.fetchProductsByIds(ids);
  }

  // 3. Salva um novo ID no Hive
  Future<void> addNewFavority(int productId) async {
    final ids = getSavedIds();
    if (!ids.contains(productId)) {
      ids.add(productId);
      await boxFavoritiesProducts.put("favorities_ids", ids);
    }
  }

  // 4. Remove um ID do Hive
  Future<void> removeFavority(int productId) async {
    final ids = getSavedIds();
    ids.remove(productId);
    await boxFavoritiesProducts.put("favorities_ids", ids);
  }
}
