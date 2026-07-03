import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/cart/pages/cart_page.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/categories/pages/categories_page.dart';
import 'package:growstore/features/favorites/pages/favority_page.dart';
import 'package:growstore/features/home/pages/home_page.dart';
import 'package:growstore/features/navigation/store/navigation_store.dart';
import 'package:growstore/features/orders/pages/orders_page.dart';

class MainNavigationPage extends StatelessWidget {
  MainNavigationPage({super.key});

  final navigationStore = GetIt.I<NavigationStore>();
  final cartStore = GetIt.I<CartStore>();

  final pages = [
    const HomePage(),
    const CategoriesPage(),
    const CartPage(),
    const FavorityPage(),
    const OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          return IndexedStack(
            index: navigationStore.currentIndex,
            children: pages,
          );
        },
      ),
      bottomNavigationBar: Observer(
        builder: (_) {
          return NavigationBar(
            selectedIndex: navigationStore.currentIndex,
            onDestinationSelected: navigationStore.changePage,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: "Home",
                selectedIcon: Icon(Icons.home),
              ),
              const NavigationDestination(
                icon: Icon(Icons.grid_view_outlined),
                label: "Categorias",
                selectedIcon: Icon(Icons.grid_view_rounded),
              ),
              NavigationDestination(
                icon: _cartIcon(Icons.shopping_cart_outlined),
                label: "Carrinho",
                selectedIcon: _cartIcon(Icons.shopping_cart_rounded),
              ),
              const NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                label: "Favoritos",
                selectedIcon: Icon(Icons.favorite_rounded),
              ),
              const NavigationDestination(
                icon: Icon(Icons.shopping_bag_outlined),
                label: "Pedidos",
                selectedIcon: Icon(Icons.shopping_bag_rounded),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _cartIcon(IconData icon) {
    final totalItems = cartStore.totalItems;

    return Badge(
      isLabelVisible: totalItems > 0,
      label: Text(totalItems > 99 ? '99+' : '$totalItems'),
      child: Icon(icon),
    );
  }
}
