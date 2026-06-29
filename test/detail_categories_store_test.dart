import 'package:flutter_test/flutter_test.dart';
import 'package:growstore/features/categories/models/category_model.dart';
import 'package:growstore/features/categories/repositories/categories_repository.dart';
import 'package:growstore/features/categories/stores/detail_categories_store.dart';
import 'package:growstore/features/home/models/home_product_model.dart';

void main() {
  group('Camada de estado - Store de produtos por categoria', () {
    test(
      'deve carregar somente os produtos da categoria informada',
      () async {
        final repository = _RepositorioCategoriasFake(
          productsResult: const [
            HomeProductModel(
              id: 8,
              name: 'Camiseta Growdev',
              category: 'Vestuário',
              price: 'R\$ 59,90',
              priceValue: 59.90,
              asset: 'https://example.com/camiseta.png',
            ),
          ],
        );
        final store = DetailCategoriesStore(
          repository: repository,
          categoryId: 21,
        );

        final carregamento = store.loadProducts();

        expect(store.isLoading, isTrue);

        await carregamento;

        expect(store.isLoading, isFalse);
        expect(store.errorMessage, isNull);
        expect(repository.requestedCategoryId, 21);
        expect(store.products, hasLength(1));
        expect(store.products.single.name, 'Camiseta Growdev');
      },
    );

    test('deve filtrar produtos pelo nome ignorando espaços e maiúsculas', () async {
      final repository = _RepositorioCategoriasFake(
        productsResult: const [
          HomeProductModel(
            id: 8,
            name: 'Camiseta Growdev',
            category: 'Vestuário',
            price: 'R\$ 59,90',
            priceValue: 59.90,
            asset: '',
          ),
          HomeProductModel(
            id: 15,
            name: 'Mousepad Grid Line',
            category: 'Informática',
            price: 'R\$ 49,90',
            priceValue: 49.90,
            asset: '',
          ),
        ],
      );
      final store = DetailCategoriesStore(
        repository: repository,
        categoryId: 21,
      );
      await store.loadProducts();

      store.setSearch('  CAMISETA  ');

      expect(store.filteredProducts, hasLength(1));
      expect(store.filteredProducts.single.name, 'Camiseta Growdev');
    });

    test('deve armazenar o erro e encerrar o carregamento', () async {
      final repository = _RepositorioCategoriasFake(
        productsError: Exception('Falha ao buscar produtos'),
      );
      final store = DetailCategoriesStore(
        repository: repository,
        categoryId: 21,
      );

      await store.loadProducts();

      expect(store.isLoading, isFalse);
      expect(store.products, isEmpty);
      expect(store.errorMessage, contains('Falha ao buscar produtos'));
    });
  });
}

class _RepositorioCategoriasFake implements CategoriesRepository {
  _RepositorioCategoriasFake({
    this.productsResult = const [],
    this.productsError,
  });

  final List<HomeProductModel> productsResult;
  final Object? productsError;
  int? requestedCategoryId;

  @override
  Future<List<CategoryModel>> getCategories() async => const [];

  @override
  Future<List<HomeProductModel>> getProductsByCategory(int categoryId) async {
    requestedCategoryId = categoryId;
    if (productsError != null) throw productsError!;
    return productsResult;
  }
}
