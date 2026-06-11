import 'package:growstore/features/catalog/models/product_model.dart';
import 'package:growstore/features/catalog/services/product_api_service.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'catalog_store.g.dart';

// This is the class used by rest of your codebase
class CatalogStore = CatalogStoreBase with _$CatalogStore;

// The store-class
abstract class CatalogStoreBase with Store {
  final ProductApiService _service = ProductApiService();

  @observable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @observable
  ObservableList<ProductModel> _products = <ProductModel>[].asObservable();
  ObservableList<ProductModel> get products => _products;

  @action
  Future<void> loadProducts() async {
    _isLoading = true;

    final responseProducts = await _service.responseProduct();

    _products.addAll(responseProducts);

    _isLoading = false;
  }
}
