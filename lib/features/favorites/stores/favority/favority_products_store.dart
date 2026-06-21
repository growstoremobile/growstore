import 'package:get_it/get_it.dart';
import 'package:growstore/features/favorites/repositories/favority_repository.dart';
import 'package:mobx/mobx.dart';

part 'favority_products_store.g.dart';

class FavorityProductsStore = FavorityProductsStoreBase
    with _$FavorityProductsStore;

abstract class FavorityProductsStoreBase with Store {
  final _repository = GetIt.I.get<FavorityRepository>();

  @observable
  ObservableList<Map<String, dynamic>> favorities = <Map<String, dynamic>>[]
      .asObservable();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> getFavorities() async {
    isLoading = true;
    errorMessage = null; // Limpa erros anteriores ao tentar novamente

    try {
      final listFromRepository = await _repository.getAllFavorities();
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
  Future<void> toggleFavority(Map<String, dynamic> product) async {
    final int productId = product['id'];
    final isAlreadyFavorite = favorities.any((p) => p['id'] == productId);

    if (isAlreadyFavorite) {
      // Se já está nos favoritos, remove
      await _repository.removeFavority(productId);
      favorities.removeWhere((p) => p['id'] == productId);
    } else {
      // Se não está, adiciona
      await _repository.addNewFavority(productId);
      favorities.add(product);
    }
  }

  // Função auxiliar rápida para checar o estado do coração na UI global
  bool isFavorite(int productId) {
    return _repository.getSavedIds().contains(productId);
  }
}
