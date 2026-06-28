import 'package:growstore/features/categories/repositories/categories_repository.dart';
import 'package:growstore/features/home/models/home_product_model.dart';
import 'package:mobx/mobx.dart';

part 'detail_categories_store.g.dart';

class DetailCategoriesStore = DetailCategoriesStoreBase
    with _$DetailCategoriesStore;

abstract class DetailCategoriesStoreBase with Store {
  DetailCategoriesStoreBase({
    required CategoriesRepository repository,
    required this.categoryId,
  }) : _repository = repository;

  final CategoriesRepository _repository;
  final int categoryId;

  @observable
  bool isLoading = false;

  @observable
  String search = '';

  @observable
  String? errorMessage;

  @observable
  ObservableList<HomeProductModel> products = <HomeProductModel>[]
      .asObservable();

  @computed
  List<HomeProductModel> get filteredProducts {
    final normalizedSearch = search.trim().toLowerCase();
    if (normalizedSearch.isEmpty) return products.toList();

    return products
        .where(
          (product) => product.name.toLowerCase().contains(normalizedSearch),
        )
        .toList();
  }

  @action
  void setSearch(String value) => search = value;

  @action
  void clearError() => errorMessage = null;

  @action
  Future<void> loadProducts() async {
    try {
      isLoading = true;
      errorMessage = null;

      final responseProducts = await _repository.getProductsByCategory(
        categoryId,
      );

      products
        ..clear()
        ..addAll(responseProducts);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
    }
  }
}
