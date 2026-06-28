import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:growstore/features/categories/models/category_model.dart';
import 'package:growstore/features/categories/repositories/categories_repository.dart';
import 'package:growstore/features/categories/stores/detail_categories_store.dart';
import 'package:growstore/features/categories/widgets/category_bottom_navigation.dart';
import 'package:growstore/features/categories/widgets/category_search_bar.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';
import 'package:growstore/shared/products/services/product_service.dart';
import 'package:growstore/shared/widgets/app_error_dialog.dart';
import 'package:growstore/shared/widgets/default_product_card_widget.dart';
import 'package:mobx/mobx.dart';

class DetailCategoriesPage extends StatefulWidget {
  const DetailCategoriesPage({super.key, required this.category});

  final CategoryModel category;

  @override
  State<DetailCategoriesPage> createState() => _DetailCategoriesPageState();
}

class _DetailCategoriesPageState extends State<DetailCategoriesPage> {
  late final DetailCategoriesStore _store;
  late final ReactionDisposer _errorDisposer;

  @override
  void initState() {
    super.initState();
    _store = DetailCategoriesStore(
      repository: CategoriesRepository(productService: ProductService()),
      categoryId: widget.category.id,
    );

    _errorDisposer = reaction<String?>((_) => _store.errorMessage, (message) {
      if (message == null || !mounted) return;

      showAppErrorDialog(context: context, message: message);
      _store.clearError();
    });

    _store.loadProducts();
  }

  @override
  void dispose() {
    _errorDisposer();
    super.dispose();
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Pedidos em breve.')));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = HomeLayoutColors.resolve(isDark);

    return Scaffold(
      appBar: AppBar(title: Text(widget.category.title), centerTitle: true),
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

                      return DefaultProductCard(
                        titleProduct: product.name,
                        price: product.priceValue,
                        pathImage: product.asset,
                        iconButton: Icons.visibility_outlined,
                        textButton: 'Ver produto',
                        onPressed: () => Navigator.of(context).pushNamed(
                          '/productDetail',
                          arguments: product.id.toString(),
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
