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
  static const _pageSize = 8;

  final _controller = TextEditingController();
  final _scrollController = ScrollController();
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
  int _visibleCount = _pageSize;
  _ProductListMode _viewMode = _ProductListMode.grid;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_filterProducts);
    _scrollController.addListener(_handleScroll);
    _loadProducts();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_filterProducts)
      ..dispose();
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _visibleProducts {
    return _filteredProducts.take(_visibleCount).toList();
  }

  bool get _canLoadMore => _visibleCount < _filteredProducts.length;

  void _handleScroll() {
    if (!_scrollController.hasClients || !_canLoadMore) return;

    if (_scrollController.position.extentAfter < 420) {
      _loadMoreProducts();
    }
  }

  void _loadMoreProducts() {
    if (!_canLoadMore) return;

    setState(() {
      final nextCount = _visibleCount + _pageSize;
      _visibleCount = nextCount > _filteredProducts.length
          ? _filteredProducts.length
          : nextCount;
    });
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
        _visibleCount = _pageSize;
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
        _visibleCount = _pageSize;
        return;
      }

      _filteredProducts = _products.where((product) {
        final title = (product['title'] ?? '').toString().toLowerCase();
        final description = (product['description'] ?? '')
            .toString()
            .toLowerCase();

        return title.contains(query) || description.contains(query);
      }).toList();
      _visibleCount = _pageSize;
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
        Navigator.of(context).pushNamed('/orders');
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

    return Column(
      children: [
        _ProductListToolbar(
          total: _filteredProducts.length,
          visible: _visibleProducts.length,
          viewMode: _viewMode,
          colors: colors,
          onViewModeChanged: (mode) {
            setState(() {
              _viewMode = mode;
              _visibleCount = _pageSize;
            });
          },
        ),
        Expanded(child: _buildProductList(colors)),
      ],
    );
  }

  Widget _buildProductList(CategoryLayoutColors colors) {
    final products = _visibleProducts;

    if (_viewMode == _ProductListMode.list) {
      return ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        cacheExtent: 420,
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final product = products[index];

          return CategoryProductListTile(
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

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      cacheExtent: 420,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 177 / 250,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

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

enum _ProductListMode { grid, list }

class _ProductListToolbar extends StatelessWidget {
  const _ProductListToolbar({
    required this.total,
    required this.visible,
    required this.viewMode,
    required this.colors,
    required this.onViewModeChanged,
  });

  final int total;
  final int visible;
  final _ProductListMode viewMode;
  final CategoryLayoutColors colors;
  final ValueChanged<_ProductListMode> onViewModeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.page,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$visible de $total produtos',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.categoryMeta,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _ViewModeButton(
            tooltip: 'Grade',
            icon: Icons.grid_view_rounded,
            selected: viewMode == _ProductListMode.grid,
            colors: colors,
            onTap: () => onViewModeChanged(_ProductListMode.grid),
          ),
          const SizedBox(width: 6),
          _ViewModeButton(
            tooltip: 'Lista',
            icon: Icons.view_agenda_outlined,
            selected: viewMode == _ProductListMode.list,
            colors: colors,
            onTap: () => onViewModeChanged(_ProductListMode.list),
          ),
        ],
      ),
    );
  }
}

class _ViewModeButton extends StatelessWidget {
  const _ViewModeButton({
    required this.tooltip,
    required this.icon,
    required this.selected,
    required this.colors,
    required this.onTap,
  });

  final String tooltip;
  final IconData icon;
  final bool selected;
  final CategoryLayoutColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: SizedBox.square(
        dimension: 36,
        child: IconButton(
          onPressed: selected ? null : onTap,
          icon: Icon(icon, size: 20),
          color: selected ? Colors.white : colors.primary,
          disabledColor: Colors.white,
          style: IconButton.styleFrom(
            backgroundColor: selected ? colors.primary : colors.page,
            side: BorderSide(color: colors.categoryBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
        ),
      ),
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
