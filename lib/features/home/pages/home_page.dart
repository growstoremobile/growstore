import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/theme/theme_mode_controller.dart';
import 'package:growstore/core/theme/widgets/empty_state_widget.dart';
import 'package:growstore/core/theme/widgets/error_state_widget.dart';
import 'package:growstore/core/theme/widgets/loading_widget.dart';
import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/cart/widgets/cart/cart_feedback_snackbar.dart';
import 'package:growstore/features/favorites/models/favority_model.dart';
import 'package:growstore/features/favorites/stores/favority/favority_products_store.dart';
import 'package:growstore/features/home/models/home_carousel_item_model.dart';
import 'package:growstore/features/home/models/home_product_model.dart';
import 'package:growstore/features/home/stores/home/home_store.dart';
import 'package:growstore/features/home/widgets/home_bottom_navigation.dart';
import 'package:growstore/features/home/widgets/home_category_carousel.dart';
import 'package:growstore/features/home/widgets/home_featured_title.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';
import 'package:growstore/features/home/widgets/home_product_grid.dart';
import 'package:growstore/features/home/widgets/home_promo_carousel.dart';
import 'package:growstore/features/home/widgets/home_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CartStore _cartStore = GetIt.I.isRegistered<CartStore>()
      ? GetIt.I<CartStore>()
      : CartStore();

  final FavorityProductsStore? _favorityStore =
      GetIt.I.isRegistered<FavorityProductsStore>()
      ? GetIt.I<FavorityProductsStore>()
      : null;

  final HomeStore _homeStore = GetIt.I.isRegistered<HomeStore>()
      ? GetIt.I<HomeStore>()
      : HomeStore();

  static const _carousel = [
    HomeCarouselItemModel(
      asset: 'assets/images/figma_home_carousel_tshirt.png',
      width: 120,
    ),
    HomeCarouselItemModel(
      asset: 'assets/images/figma_home_carousel_kit.png',
      width: 213,
    ),
    HomeCarouselItemModel(
      asset: 'assets/images/figma_home_carousel_devices.png',
      width: 120,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _homeStore.loadProducts();
  }

  void _comingSoon(BuildContext context, String destination) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$destination em breve.')));
  }

  void _handleBottomNavigation(BuildContext context, String label) {
    switch (label) {
      case 'Inicio':
        break;
      case 'Categorias':
        Navigator.of(context).pushNamed('/catalog');
        break;
      case 'Carrinho':
        Navigator.of(context).pushNamed('/cart');
        break;
      case 'Favoritos':
        Navigator.of(context).pushNamed('/favorites').then((_) {
          if (!mounted) return;
          setState(() {});
        });
        break;
      case 'Pedidos':
        _comingSoon(context, label);
        break;
    }
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

  void _addToCart(HomeProductModel product) {
    _cartStore.addItem(
      CartItemModel(
        id: product.id.toString(),
        name: product.name,
        variation: product.category,
        price: product.priceValue,
        imageUrl: product.asset,
      ),
    );

    showCartFeedbackSnackBar(
      context,
      title: 'Adicionado ao carrinho',
      subtitle: product.name,
      onViewCart: () => Navigator.of(context).pushNamed('/cart'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = HomeLayoutColors.resolve(isDark);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: colors.statusBar,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: colors.bottomBar,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: colors.page,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              HomeSearchBar(
                colors: colors,
                isDark: isDark,
                onSearch: () => Navigator.of(context).pushNamed('/search'),
                onProfile: () => Navigator.of(context).pushNamed('/profile'),
                onThemeToggle: () => ThemeModeController.of(
                  context,
                ).toggleTheme(Theme.of(context).brightness),
              ),
              Divider(height: 1, thickness: 1, color: colors.divider),
              Expanded(
                child: Observer(
                  builder: (_) => RefreshIndicator(
                    color: colors.primary,
                    onRefresh: _homeStore.loadProducts,
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      cacheExtent: 360,
                      slivers: [
                        SliverToBoxAdapter(
                          child: HomeCategoryCarousel(
                            categories: _homeStore.categories,
                            selectedCategory: _homeStore.selectedCategory,
                            colors: colors,
                            onSelected: _homeStore.selectCategory,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: HomePromoCarousel(
                            items: _carousel,
                            colors: colors,
                            isDark: isDark,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: HomeFeaturedTitle(
                            colors: colors,
                            onViewAll: () =>
                                Navigator.of(context).pushNamed('/search'),
                          ),
                        ),
                        _buildProductsContent(colors),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Observer(
          builder: (_) => HomeBottomNavigation(
            cartItemCount: _cartStore.totalItems,
            onTap: (label) => _handleBottomNavigation(context, label),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsContent(HomeLayoutColors colors) {
    if (_homeStore.isLoading) {
      return SliverToBoxAdapter(child: _HomeProductsLoading(colors: colors));
    }

    if (_homeStore.errorMessage != null) {
      return SliverToBoxAdapter(
        child: _HomeStateContainer(
          colors: colors,
          child: GrowErrorState(
            type: GrowErrorType.custom,
            title: 'Erro ao carregar produtos',
            description: _homeStore.errorMessage,
            onRetry: _homeStore.loadProducts,
          ),
        ),
      );
    }

    if (_homeStore.filteredProducts.isEmpty) {
      return SliverToBoxAdapter(
        child: _HomeStateContainer(
          colors: colors,
          child: const GrowEmptyState(
            icon: Icons.inventory_2_outlined,
            title: 'Nenhum produto encontrado',
            description: 'Tente escolher outra categoria.',
          ),
        ),
      );
    }

    return HomeProductSliverGrid(
      products: _homeStore.filteredProducts,
      colors: colors,
      isFavorite: _isFavorite,
      onFavoriteToggle: _toggleFavorite,
      onAddToCart: _addToCart,
      onTap: (product) => Navigator.of(
        context,
      ).pushNamed('/productDetail', arguments: product.id.toString()),
    );
  }
}

class _HomeStateContainer extends StatelessWidget {
  const _HomeStateContainer({required this.colors, required this.child});

  final HomeLayoutColors colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.productGrid,
      constraints: const BoxConstraints(minHeight: 320),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: child,
    );
  }
}

class _HomeProductsLoading extends StatelessWidget {
  const _HomeProductsLoading({required this.colors});

  final HomeLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.productGrid,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: GridView.builder(
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 12,
          childAspectRatio: 0.58,
        ),
        itemBuilder: (_, _) => _HomeProductCardSkeleton(colors: colors),
      ),
    );
  }
}

class _HomeProductCardSkeleton extends StatelessWidget {
  const _HomeProductCardSkeleton({required this.colors});

  final HomeLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.productCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.productBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 161 / 160,
            child: GrowSkeletonBox(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 0,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GrowSkeletonBox(width: 72, height: 12),
                  SizedBox(height: 4),
                  GrowSkeletonBox(width: double.infinity, height: 18),
                  Spacer(),
                  GrowSkeletonBox(width: 88, height: 22),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
