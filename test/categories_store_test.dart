import 'package:flutter_test/flutter_test.dart';
import 'package:growstore/features/categories/models/category_model.dart';
import 'package:growstore/features/categories/repositories/categories_repository.dart';
import 'package:growstore/features/categories/stores/categories_store.dart';
import 'package:growstore/features/home/models/home_product_model.dart';

void main() {
  group('Camada de estado - Store de categorias', () {
    test('deve carregar as categorias retornadas pelo repository', () async {
      final repository = _RepositorioCategoriasFake(
        categoriesResult: const [
          CategoryModel(
            id: 1,
            title: 'Vestuário',
            productQtn: 2,
            imageUrl: 'https://example.com/vestuario.png',
          ),
          CategoryModel(
            id: 2,
            title: 'Eletrônicos',
            productQtn: 1,
            imageUrl: 'https://example.com/eletronicos.png',
          ),
        ],
      );
      final store = CategoryStore(repository: repository);

      final carregamento = store.loadCategories();

      expect(store.isLoading, isTrue);

      await carregamento;

      expect(store.isLoading, isFalse);
      expect(store.errorMessage, isNull);
      expect(store.categories, hasLength(2));
      expect(store.categories.first.title, 'Vestuário');
    });

    test('deve filtrar categorias pelo título ignorando maiúsculas', () async {
      final repository = _RepositorioCategoriasFake(
        categoriesResult: const [
          CategoryModel(
            id: 1,
            title: 'Vestuário',
            productQtn: 2,
            imageUrl: '',
          ),
          CategoryModel(
            id: 2,
            title: 'Eletrônicos',
            productQtn: 1,
            imageUrl: '',
          ),
        ],
      );
      final store = CategoryStore(repository: repository);
      await store.loadCategories();

      store.setSearch('ELETRÔ');

      expect(store.filteredCategories, hasLength(1));
      expect(store.filteredCategories.single.title, 'Eletrônicos');
    });

    test('deve armazenar o erro e encerrar o carregamento', () async {
      final repository = _RepositorioCategoriasFake(
        categoriesError: Exception('Falha ao buscar categorias'),
      );
      final store = CategoryStore(repository: repository);

      await store.loadCategories();

      expect(store.isLoading, isFalse);
      expect(store.categories, isEmpty);
      expect(store.errorMessage, contains('Falha ao buscar categorias'));
    });
  });
}

class _RepositorioCategoriasFake implements CategoriesRepository {
  _RepositorioCategoriasFake({
    this.categoriesResult = const [],
    this.categoriesError,
  });

  final List<CategoryModel> categoriesResult;
  final Object? categoriesError;

  @override
  Future<List<CategoryModel>> getCategories() async {
    if (categoriesError != null) throw categoriesError!;
    return categoriesResult;
  }

  @override
  Future<List<HomeProductModel>> getProductsByCategory(int categoryId) async {
    return const [];
  }
}
