import 'package:flutter/foundation.dart';
import 'package:growstore/features/home/models/home_product_model.dart';
import 'package:growstore/features/home/repositories/home_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  HomeStoreBase([HomeRepository? repository])
    : _repository = repository ?? HomeRepository();

  final HomeRepository _repository;

  @observable
  ObservableList<HomeProductModel> products =
      ObservableList<HomeProductModel>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String selectedCategory = 'Todas';

  @computed
  List<String> get categories {
    final values =
        products
            .map((product) => product.category)
            .where((category) => category.trim().isNotEmpty)
            .toSet()
            .toList()
          ..sort();

    return ['Todas', ...values];
  }

  @computed
  List<HomeProductModel> get filteredProducts {
    if (selectedCategory == 'Todas') return products.toList();

    return products
        .where((product) => product.category == selectedCategory)
        .toList();
  }

  @action
  Future<void> loadProducts() async {
    try {
      isLoading = true;
      errorMessage = null;

      final result = await _repository.getFeaturedProducts();
      products = ObservableList<HomeProductModel>.of(result);

      if (!categories.contains(selectedCategory)) {
        selectedCategory = 'Todas';
      }
    } catch (exception, stack) {
      final message = exception.toString();
      debugPrint('[HomeStore] loadProducts falhou: $message');
      debugPrint('$stack');
      errorMessage = 'Nao foi possivel carregar os produtos: $message';
    } finally {
      isLoading = false;
    }
  }

  @action
  void selectCategory(String category) {
    selectedCategory = category;
  }
}
