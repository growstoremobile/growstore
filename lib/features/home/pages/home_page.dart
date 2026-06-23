import 'package:flutter/material.dart';
import 'package:growstore/features/home/widgets/home_bottom_navigation.dart';
import 'package:growstore/features/home/widgets/home_category_card.dart';
import 'package:growstore/features/home/widgets/home_header.dart';
import 'package:growstore/features/home/widgets/home_hero.dart';
import 'package:growstore/features/home/widgets/home_menu_drawer.dart';
import 'package:growstore/features/home/widgets/home_newsletter.dart';
import 'package:growstore/features/home/widgets/home_product_card.dart';
import 'package:growstore/features/home/widgets/home_section_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _page = Color(0xFF04090F);
  static const _green = Color(0xFF39FF14);

  void _comingSoon(BuildContext context, String destination) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$destination em breve.')));
  }

  void _handleBottomNavigation(BuildContext context, String label) {
    switch (label) {
      case 'Home':
        break;
      case 'Carrinho':
        Navigator.of(context).pushNamed('/cart');
        break;
      default:
        _comingSoon(context, label);
    }
  }

  void _handleMenuSelection(BuildContext context, String action) {
    Navigator.of(context).pop();

    switch (action) {
      case 'home':
        break;
      case 'cart':
        Navigator.of(context).pushNamed('/cart');
        break;
      case 'favorites':
        Navigator.of(context).pushNamed('/favorites');
        break;
      case 'shop':
        _comingSoon(context, 'Loja');
        break;
      case 'profile':
        _comingSoon(context, 'Perfil');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: _page,
      drawer: HomeMenuDrawer(
        onSelected: (action) => _handleMenuSelection(context, action),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            HomeHeader(
              onMenu: () => scaffoldKey.currentState?.openDrawer(),
              onSearch: () => _comingSoon(context, 'Busca'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHero(
                      onShop: () => _comingSoon(context, 'Coleção de treino'),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 64, 20, 0),
                      child: HomeSectionTitle('SHOP BY CATEGORY'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                      child: HomeCategoryCard(
                        title: 'APPAREL',
                        subtitle: 'COLLECTION 2024',
                        asset: 'assets/images/figma_category_apparel.png',
                        alignment: Alignment.topCenter,
                        onTap: () => _comingSoon(context, 'Roupas'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: HomeCategoryCard(
                        title: 'ACCESSORIES',
                        subtitle: 'ESSENTIALS',
                        asset: 'assets/images/figma_category_accessories.png',
                        alignment: Alignment.bottomRight,
                        onTap: () => _comingSoon(context, 'Acessórios'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 64, 20, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const HomeSectionTitle('FEATURED\nPRODUCTS'),
                          TextButton(
                            onPressed: () =>
                                _comingSoon(context, 'Todos os produtos'),
                            style: TextButton.styleFrom(
                              foregroundColor: _green,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  'VIEW\nALL',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 16 / 12,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.chevron_right, size: 14),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 167 / 335,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          HomeProductCard(
                            category: 'APPAREL',
                            title: 'CORE LOGO TEE',
                            price: 'R\$ 129,90',
                            asset: 'assets/images/figma_product_apparel.png',
                            onTap: () => _comingSoon(context, 'Core Logo Tee'),
                          ),
                          HomeProductCard(
                            category: 'GEAR',
                            title: 'COMMUTER\nBACKPACK',
                            price: 'R\$ 499,90',
                            asset: 'assets/images/figma_product_backpack.png',
                            onTap: () => _comingSoon(context, 'Backpack'),
                          ),
                          HomeProductCard(
                            category: 'DRINKWARE',
                            title: 'DEVELOPER MUG',
                            price: 'R\$ 59,90',
                            asset: 'assets/images/figma_product_bottle.png',
                            onTap: () => _comingSoon(context, 'Developer Mug'),
                          ),
                          HomeProductCard(
                            category: 'ACCESSORIES',
                            title: 'SLEEVE 14" PRO',
                            price: 'R\$ 189,90',
                            asset: 'assets/images/figma_product_sleeve.png',
                            onTap: () => _comingSoon(context, 'Sleeve 14 Pro'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 64, 20, 160),
                      child: HomeNewsletter(
                        onSubscribe: () =>
                            _comingSoon(context, 'Inscrição confirmada'),
                      ),
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
    );
  }
}
