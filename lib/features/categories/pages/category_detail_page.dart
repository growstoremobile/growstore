import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/categories/widgets/category_header.dart';
import 'package:growstore/features/categories/widgets/category_layout_colors.dart';
import 'package:growstore/features/categories/widgets/category_product_card.dart';
import 'package:growstore/features/favorites/models/favority_model.dart';
import 'package:growstore/features/favorites/stores/favority/favority_products_store.dart';
import 'package:growstore/features/home/widgets/home_bottom_navigation.dart';
import 'package:growstore/shared/products/services/product_service.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  final _controller = TextEditingController();
  final _productService = ProductService();
  final CartStore? _cartStore = GetIt.I.isRegistered<CartStore>()
      ? GetIt.I<CartStore>()
      : null;
  final FavorityProductsStore? _favorityStore =
      GetIt.I.isRegistered<FavorityProductsStore>()
      ? GetIt.I<FavorityProductsStore>()
      : null;

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _filteredProducts = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_filterProducts);
    _loadProducts();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_filterProducts)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _productService.fetchAllProducts();
      final categoryProducts = products.where((product) {
        return (product['category'] ?? '').toString() == widget.categoryName;
      }).toList();

      if (!mounted) return;
      setState(() {
        _products = categoryProducts;
        _filteredProducts = categoryProducts;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Nao foi possivel carregar os produtos.';
        _isLoading = false;
      });
    }
  }

  void _filterProducts() {
    final query = _controller.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _products;
        return;
      }

      _filteredProducts = _products.where((product) {
        final title = (product['title'] ?? '').toString().toLowerCase();
        final description = (product['description'] ?? '')
            .toString()
            .toLowerCase();

        return title.contains(query) || description.contains(query);
      }).toList();
    });
  }

  Future<void> _toggleFavorite(Map<String, dynamic> product) async {
    final store = _favorityStore;
    if (store == null) return;

    await store.toggleFavority(FavorityModel.fromJson(product));
    if (!mounted) return;
    setState(() {});
  }

  bool _isFavorite(Map<String, dynamic> product) {
    final id = product['id'];
    final productId = id is int ? id : int.tryParse(id?.toString() ?? '');
    if (productId == null) return false;

    return _favorityStore?.isFavorite(productId) ?? false;
  }

  void _handleBottomNavigation(String label) {
    switch (label) {
      case 'Inicio':
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/home', (route) => false);
        break;
      case 'Categorias':
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/categories',
          (route) => route.settings.name == '/home',
        );
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
              title: widget.categoryName,
              colors: colors,
              controller: _controller,
              onClear: _controller.clear,
              onBack: () => Navigator.of(context).pop(),
              onProfile: () => Navigator.of(context).pushNamed('/profile'),
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
      return _CategoryDetailState(
        colors: colors,
        icon: Icons.wifi_off_rounded,
        title: 'Erro ao carregar',
        description: _errorMessage!,
        onRetry: () {
          setState(() {
            _isLoading = true;
            _errorMessage = null;
          });
          _loadProducts();
        },
      );
    }

    if (_filteredProducts.isEmpty) {
      return _CategoryDetailState(
        colors: colors,
        icon: Icons.inventory_2_outlined,
        title: 'Nenhum produto encontrado',
        description: 'Tente buscar outro termo nesta categoria.',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      cacheExtent: 360,
      itemCount: _filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 177 / 250,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];

        return CategoryProductCard(
          product: product,
          colors: colors,
          isFavorite: _isFavorite(product),
          onFavorite: () => _toggleFavorite(product),
          onTap: () => Navigator.of(
            context,
          ).pushNamed('/productDetail', arguments: product['id'].toString()),
        );
      },
    );
  }
}

class _CategoryDetailState extends StatelessWidget {
  const _CategoryDetailState({
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
