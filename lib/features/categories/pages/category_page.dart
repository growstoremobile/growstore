import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/categories/models/category_summary.dart';
import 'package:growstore/features/categories/widgets/category_header.dart';
import 'package:growstore/features/categories/widgets/category_layout_colors.dart';
import 'package:growstore/features/categories/widgets/category_tile.dart';
import 'package:growstore/features/home/widgets/home_bottom_navigation.dart';
import 'package:growstore/shared/products/services/product_service.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _productService = ProductService();
  final CartStore? _cartStore = GetIt.I.isRegistered<CartStore>()
      ? GetIt.I<CartStore>()
      : null;

  List<CategorySummary> _categories = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final products = await _productService.fetchAllProducts();
      final counts = <String, int>{};

      for (final product in products) {
        final category = (product['category'] ?? 'Produto').toString().trim();
        final name = category.isEmpty ? 'Produto' : category;
        counts[name] = (counts[name] ?? 0) + 1;
      }

      final categories =
          counts.entries
              .map(
                (entry) =>
                    CategorySummary(name: entry.key, productCount: entry.value),
              )
              .toList()
            ..sort((a, b) => a.name.compareTo(b.name));

      if (!mounted) return;
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Nao foi possivel carregar as categorias.';
        _isLoading = false;
      });
    }
  }

  void _handleBottomNavigation(String label) {
    switch (label) {
      case 'Inicio':
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/home', (route) => false);
        break;
      case 'Categorias':
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
    final colors = CategoryLayoutColors.resolve(
      Theme.of(context).brightness == Brightness.dark,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: colors.header,
        statusBarIconBrightness: colors.isDark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: colors.isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: colors.bottomBar,
        systemNavigationBarIconBrightness: colors.isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: colors.page,
        body: Column(
          children: [
            CategoryHeader(
              title: 'Categorias',
              colors: colors,
              onProfile: () => Navigator.of(context).pushNamed('/profile'),
              onSearchTap: () => Navigator.of(context).pushNamed('/search'),
            ),
            Expanded(child: _buildBody(colors)),
          ],
        ),
        bottomNavigationBar: HomeBottomNavigation(
          selectedLabel: 'Categorias',
          cartItemCount: _cartStore?.totalItems ?? 0,
          showCartBadge: false,
          onTap: _handleBottomNavigation,
        ),
      ),
    );
  }

  Widget _buildBody(CategoryLayoutColors colors) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(color: colors.primary));
    }

    if (_errorMessage != null) {
      return _CategoryState(
        colors: colors,
        icon: Icons.wifi_off_rounded,
        title: 'Erro ao carregar',
        description: _errorMessage!,
        onRetry: () {
          setState(() {
            _isLoading = true;
            _errorMessage = null;
          });
          _loadCategories();
        },
      );
    }

    if (_categories.isEmpty) {
      return _CategoryState(
        colors: colors,
        icon: Icons.grid_view_rounded,
        title: 'Nenhuma categoria',
        description: 'Os produtos carregados ainda nao possuem categorias.',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
      cacheExtent: 320,
      itemCount: _categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 19,
        mainAxisSpacing: 17,
      ),
      itemBuilder: (context, index) {
        final category = _categories[index];

        return CategoryTile(
          category: category,
          colors: colors,
          onTap: () => Navigator.of(
            context,
          ).pushNamed('/categoryDetail', arguments: category.name),
        );
      },
    );
  }
}

class _CategoryState extends StatelessWidget {
  const _CategoryState({
    required this.colors,
    required this.icon,
    required this.title,
    required this.description,
    this.onRetry,
  });

  final CategoryLayoutColors colors;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: colors.primary, size: 44),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.categoryText,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.categoryMeta, fontSize: 14),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 18),
              FilledButton(
                onPressed: onRetry,
                style: FilledButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Tentar novamente'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
