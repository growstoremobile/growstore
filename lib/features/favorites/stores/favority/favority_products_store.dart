import 'package:get_it/get_it.dart';
import 'package:growstore/features/favorites/models/favority_model.dart';
import 'package:growstore/features/favorites/repositories/favority_repository.dart';
import 'package:mobx/mobx.dart';

part 'favority_products_store.g.dart';

class FavorityProductsStore = FavorityProductsStoreBase
    with _$FavorityProductsStore;

abstract class FavorityProductsStoreBase with Store {
  final _repository = GetIt.I.get<FavorityRepository>();

  @observable
  ObservableList<FavorityModel> favorities = <FavorityModel>[].asObservable();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> getFavorities() async {
    isLoading = true;
    errorMessage = null;

    try {
      final listFromRepository = await _repository.getAllFavorites();
      favorities.clear();
      favorities.addAll(listFromRepository);
    } catch (e) {
      errorMessage =
          "Não foi possível carregar seus favoritos. Verifique sua conexão.";
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> toggleFavority(FavorityModel product) async {
    final int productId = product.id;
    final isAlreadyFavorite = favorities.any((p) => p.id == productId);

    if (isAlreadyFavorite) {
      await _repository.removeFavority(productId);
      favorities.removeWhere((p) => p.id == productId);
    } else {
      await _repository.addNewFavority(productId);
      favorities.add(product);
    }
  }

  bool isFavorite(int productId) {
    return _repository.getSavedIds().contains(productId);
  }
}
