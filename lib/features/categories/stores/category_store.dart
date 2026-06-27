import 'package:growstore/features/categories/models/category_model.dart';
import 'package:growstore/features/categories/services/category_service.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'category_store.g.dart';

// This is the class used by rest of your codebase
class CategoryStore = CategoryStoreBase with _$CategoryStore;

// The store-class
abstract class CategoryStoreBase with Store {
  final CategoryService _categoryService;

  CategoryStoreBase({required CategoryService categoryService})
    : _categoryService = categoryService;

  @observable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @observable
  // ignore: prefer_final_fields
  ObservableList<CategoryModel> _categories = <CategoryModel>[].asObservable();
  ObservableList<CategoryModel> get categories => _categories;

  @observable
  String? search;

  @observable
  String? errorMessage;

  @action
  void setSearch(String? text) => search = text;

  @action
  void clearError() => errorMessage = null;

  @computed
  List<CategoryModel> get filteredCategories {
    if (search == null || search!.isEmpty) return _categories.toList();

    return _categories
        .where(
          (category) =>
              category.title.toLowerCase().contains(search!.toLowerCase()),
        )
        .toList();
  }

  @action
  Future<void> loadCategories() async {
    try {
      _isLoading = true;

      final responseCategories = await _categoryService.getCategories();

      _categories.addAll(responseCategories);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      _isLoading = false;
    }
  }
}
