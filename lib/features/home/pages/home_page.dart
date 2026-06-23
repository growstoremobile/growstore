import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growstore/features/home/models/home_carousel_item_model.dart';
import 'package:growstore/features/home/models/home_product_model.dart';
import 'package:growstore/features/home/widgets/home_bottom_navigation.dart';
import 'package:growstore/features/home/widgets/home_category_carousel.dart';
import 'package:growstore/features/home/widgets/home_featured_title.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';
import 'package:growstore/features/home/widgets/home_product_grid.dart';
import 'package:growstore/features/home/widgets/home_promo_carousel.dart';
import 'package:growstore/features/home/widgets/home_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      price: 'R\$ 79,90',
      asset: 'assets/images/figma_home_product_tshirt.png',
    ),
    HomeProductModel(
      name: 'Kit Adesivos',
      price: 'R\$ 5,90',
      asset: 'assets/images/figma_home_product_stickers.png',
    ),
    HomeProductModel(
      name: 'Caneca preta',
      price: 'R\$ 29,90',
      asset: 'assets/images/figma_home_product_mug.png',
    ),
    HomeProductModel(
      name: 'Garrafa térmica',
      price: 'R\$ 39,90',
      asset: 'assets/images/figma_home_product_bottle.png',
    ),
    HomeProductModel(
      name: 'Mochila Notebook',
      price: 'R\$ 129,90',
      asset: 'assets/images/figma_home_product_backpack.png',
    ),
    HomeProductModel(
      name: 'Mousepad',
      price: 'R\$ 19,90',
      asset: 'assets/images/figma_home_product_mousepad.png',
    ),
  ];

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
              ),
              Divider(height: 1, thickness: 1, color: colors.divider),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HomeCategoryCarousel(
                        categories: _categories,
                        colors: colors,
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
                        products: _products,
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
