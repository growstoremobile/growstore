import 'package:growstore/features/favorites/models/favority_model.dart';
import 'package:growstore/features/favorites/services/favority_service.dart';
import 'package:hive/hive.dart';

class FavorityRepository {
  final Box boxFavoritiesProducts;
  final FavorityService _favoriteService;

  FavorityRepository({
    required this.boxFavoritiesProducts,
    required FavorityService favoriteService,
  }) : _favoriteService = favoriteService;

  List<int> getSavedIds() {
    final List<dynamic> ids = boxFavoritiesProducts.get(
      "favorities_ids",
      defaultValue: <dynamic>[],
    );
    return ids.cast<int>();
  }

  Future<List<FavorityModel>> getAllFavorites() async {
    final List<int> ids = getSavedIds();
    if (ids.isEmpty) return [];

    final List<Map<String, dynamic>> rawProducts = await _favoriteService
        .fetchProductsByIds(ids);

    // Converte a lista de Maps em uma lista de objetos FavorityModel
    return rawProducts.map((json) => FavorityModel.fromJson(json)).toList();
  }

  Future<void> addNewFavority(int productId) async {
    final ids = getSavedIds();
    if (!ids.contains(productId)) {
      ids.add(productId);
      await boxFavoritiesProducts.put("favorities_ids", ids);
    }
  }

  Future<void> removeFavority(int productId) async {
    final ids = getSavedIds();
    ids.remove(productId);
    await boxFavoritiesProducts.put("favorities_ids", ids);
  }
}
