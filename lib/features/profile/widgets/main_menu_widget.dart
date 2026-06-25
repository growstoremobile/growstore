import 'package:flutter/material.dart';
import 'package:growstore/features/profile/widgets/menu_item_widget.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MenuItemWidget(icon: Icons.home, title: 'Início'),
        MenuItemWidget(icon: Icons.search, title: 'Buscar'),
        MenuItemWidget(icon: Icons.grid_view_rounded, title: 'Categorias'),
        MenuItemWidget(icon: Icons.favorite, title: 'Favoritos'),
        MenuItemWidget(icon: Icons.shopping_bag, title: 'Minhas Compras'),
        MenuItemWidget(icon: Icons.shopping_cart, title: 'Carrinho'),
      ],
    );
  }
}
