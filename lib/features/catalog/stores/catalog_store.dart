import 'package:growstore/features/catalog/models/catalog_model.dart';
import 'package:growstore/features/catalog/models/product_model.dart';
import 'package:growstore/features/catalog/services/catalog_api_service.dart';
import 'package:growstore/features/catalog/services/product_api_service.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'catalog_store.g.dart';

// This is the class used by rest of your codebase
class CatalogStore = CatalogStoreBase with _$CatalogStore;

// The store-class
abstract class CatalogStoreBase with Store {
  final ProductApiService _serviceProduct = ProductApiService();
  final CatalogApiService _serviceCatalog = CatalogApiService();

  @observable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @observable
  // ignore: prefer_final_fields
  ObservableList<CatalogModel> _catalogs = <CatalogModel>[].asObservable();
  ObservableList<CatalogModel> get catalogs => _catalogs;

  @action
  Future<void> loadCatalog() async {
    _isLoading = true;

    final responseCatalogs = await _serviceCatalog.responseCatalog();
    final responseProducts = await _serviceProduct.responseProduct();

    for (CatalogModel catalog in responseCatalogs) {
      for (ProductModel product in responseProducts) {
        if (product.categoryId == catalog.id) {
          catalog.products.add(product);
        }
      }
    }

    _catalogs.addAll(responseCatalogs);

    _isLoading = false;
  }
}
