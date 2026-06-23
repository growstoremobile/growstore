import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growstore/core/theme/theme_mode_controller.dart';
import 'package:growstore/features/home/models/home_carousel_item_model.dart';
import 'package:growstore/features/home/models/home_product_model.dart';
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
  String _selectedCategory = 'Todas';

  static const _categories = [
    'Todas',
    'Camiseta',
    'Mochila',
    'Garrafas',
    'Copos',
    'Cadernos',
    'Canetas',
    'Adesivos',
    'Mousepads',
  ];

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

  static const _products = [
    HomeProductModel(
      name: 'Camiseta preta',
      category: 'Camiseta',
      price: 'R\$ 79,90',
      asset: 'assets/images/figma_home_product_tshirt.png',
    ),
    HomeProductModel(
      name: 'Kit Adesivos',
      category: 'Adesivos',
      price: 'R\$ 5,90',
      asset: 'assets/images/figma_home_product_stickers.png',
    ),
    HomeProductModel(
      name: 'Caneca preta',
      category: 'Copos',
      price: 'R\$ 29,90',
      asset: 'assets/images/figma_home_product_mug.png',
    ),
    HomeProductModel(
      name: 'Garrafa térmica',
      category: 'Garrafas',
      price: 'R\$ 39,90',
      asset: 'assets/images/figma_home_product_bottle.png',
    ),
    HomeProductModel(
      name: 'Mochila Notebook',
      category: 'Mochila',
      price: 'R\$ 129,90',
      asset: 'assets/images/figma_home_product_backpack.png',
    ),
    HomeProductModel(
      name: 'Mousepad',
      category: 'Mousepads',
      price: 'R\$ 19,90',
      asset: 'assets/images/figma_home_product_mousepad.png',
    ),
  ];

  List<HomeProductModel> get _filteredProducts {
    if (_selectedCategory == 'Todas') return _products;

    return _products
        .where((product) => product.category == _selectedCategory)
        .toList();
  }

  void _comingSoon(BuildContext context, String destination) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$destination em breve.')));
  }

  void _handleBottomNavigation(BuildContext context, String label) {
    switch (label) {
      case 'Início':
        break;
      case 'Carrinho':
        Navigator.of(context).pushNamed('/cart');
        break;
      case 'Favoritos':
        Navigator.of(context).pushNamed('/favorites');
        break;
      case 'Categorias':
      case 'Pedidos':
        _comingSoon(context, label);
        break;
    }
  }

  void _selectCategory(String category) {
    setState(() => _selectedCategory = category);
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
                onProfile: () => _comingSoon(context, 'Perfil'),
                onThemeToggle: () => ThemeModeController.of(
                  context,
                ).toggleTheme(Theme.of(context).brightness),
              ),
              Divider(height: 1, thickness: 1, color: colors.divider),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HomeCategoryCarousel(
                        categories: _categories,
                        selectedCategory: _selectedCategory,
                        colors: colors,
                        onSelected: _selectCategory,
                      ),
                      HomePromoCarousel(
                        items: _carousel,
                        colors: colors,
                        isDark: isDark,
                      ),
                      if (isDark)
                        HomeFeaturedTitle(
                          colors: colors,
                          onViewAll: () =>
                              _comingSoon(context, 'Todos os produtos'),
                        ),
                      HomeProductGrid(
                        products: _filteredProducts,
                        colors: colors,
                        onTap: (product) => _comingSoon(context, product.name),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: HomeBottomNavigation(
          onTap: (label) => _handleBottomNavigation(context, label),
        ),
      ),
    );
  }
}
