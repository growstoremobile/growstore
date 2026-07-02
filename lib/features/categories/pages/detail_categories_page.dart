import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/theme/widgets/error_state_widget.dart';
import 'package:growstore/features/categories/models/category_model.dart';
import 'package:growstore/features/categories/stores/detail_categories_store.dart';
import 'package:growstore/features/categories/widgets/category_bottom_navigation.dart';
import 'package:growstore/features/categories/widgets/category_search_bar.dart';
import 'package:growstore/features/favorites/models/favority_model.dart';
import 'package:growstore/features/favorites/stores/favority/favority_products_store.dart';
import 'package:growstore/features/home/models/home_product_model.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';
import 'package:growstore/shared/widgets/default_product_card_widget.dart';

class DetailCategoriesPage extends StatefulWidget {
  const DetailCategoriesPage({super.key, required this.category});

  final CategoryModel category;

  @override
  State<DetailCategoriesPage> createState() => _DetailCategoriesPageState();
}

class _DetailCategoriesPageState extends State<DetailCategoriesPage> {
  late final DetailCategoriesStore _store;
  final FavorityProductsStore? _favorityStore =
      GetIt.I.isRegistered<FavorityProductsStore>()
      ? GetIt.I<FavorityProductsStore>()
      : null;

  @override
  void initState() {
    super.initState();
    _store = GetIt.I<DetailCategoriesStore>(param1: widget.category.id);

    _store.loadProducts();
  }

  Future<void> _toggleFavorite(HomeProductModel product) async {
    final favorityStore = _favorityStore;
    if (favorityStore == null) return;

    await favorityStore.toggleFavority(
      FavorityModel(
        id: product.id,
        titleProduct: product.name,
        priceProduct: product.priceValue,
        pathImage: product.asset,
      ),
    );

    if (!mounted) return;
    setState(() {});
  }

  bool _isFavorite(int productId) {
    return _favorityStore?.isFavorite(productId) ?? false;
  }

  void _handleBottomNavigation(String label) {
    switch (label) {
      case 'Inicio':
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
        break;
      case 'Categorias':
        Navigator.of(context).pop();
        break;
      case 'Carrinho':
        Navigator.of(context).pushNamed('/cart');
        break;
      case 'Favoritos':
        Navigator.of(context).pushNamed('/favorites');
        break;
      case 'Pedidos':
        Navigator.of(context).pushNamed('/orders');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = HomeLayoutColors.resolve(isDark);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(widget.category.title),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            CategorySearchBar(
              colors: colors,
              isDark: isDark,
              onSearchChanged: _store.setSearch,
              onProfile: () => Navigator.of(context).pushNamed('/profile'),
            ),
            Divider(height: 1, thickness: 1, color: colors.divider),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (_store.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_store.errorMessage != null) {
                    return GrowErrorState(
                      type: GrowErrorType.custom,
                      title: 'Erro ao carregar produtos',
                      description: 'Não foi possível carregar os produtos.',
                      onRetry: _store.loadProducts,
                    );
                  }

                  final products = _store.filteredProducts;
                  if (products.isEmpty) {
                    return const Center(
                      child: Text('Nenhum produto encontrado.'),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.58,
                        ),
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return TooltipVisibility(
                        visible: false,
                        child: DefaultProductCard(
                          titleProduct: product.name,
                          price: product.priceValue,
                          pathImage: product.asset,
                          iconFavority: _isFavorite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          onFavoritePressed: _favorityStore == null
                              ? null
                              : () => _toggleFavorite(product),
                          iconButton: Icons.visibility_outlined,
                          textButton: 'Ver produto',
                          onPressed: () => Navigator.of(context).pushNamed(
                            '/productDetail',
                            arguments: product.id.toString(),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CategoryBottomNavigation(
        onTap: _handleBottomNavigation,
      ),
    );
  }
}
