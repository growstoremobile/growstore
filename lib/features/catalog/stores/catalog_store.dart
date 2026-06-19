import 'package:growstore/features/catalog/models/catalog_model.dart';
import 'package:growstore/features/catalog/services/catalog_api_service.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'catalog_store.g.dart';

// This is the class used by rest of your codebase
class CatalogStore = CatalogStoreBase with _$CatalogStore;

// The store-class
abstract class CatalogStoreBase with Store {
  final CatalogService _serviceCatalog;

  CatalogStoreBase({required CatalogService serviceCatalog})
    : _serviceCatalog = serviceCatalog;

  @observable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @observable
  // ignore: prefer_final_fields
  ObservableList<CatalogModel> _catalogs = <CatalogModel>[].asObservable();
  ObservableList<CatalogModel> get catalogs => _catalogs;

  @observable
  String? search;

  @computed
  List<CatalogModel> get filteredCatalogs {
    if (search == null || search!.isEmpty) return _catalogs.toList();

    return _catalogs
        .where(
          (catalog) =>
              catalog.title.toLowerCase().contains(search!.toLowerCase()),
        )
        .toList();
  }

  @action
  void setSearch(String? text) => search = text;

  @action
  Future<void> loadCatalog() async {
    try {
      _isLoading = true;

      final responseCatalogs = await _serviceCatalog.getCatalogs();

      _catalogs.addAll(responseCatalogs);
    } catch (_) {
      throw Exception('Erro ao mostrar cátalogos na tela.');
    } finally {
      _isLoading = false;
    }
  }
}
