import 'package:flutter/material.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/profile/widgets/main_menu_widget.dart';
import 'package:growstore/features/profile/widgets/profile_header_widget.dart';
import 'package:growstore/features/profile/widgets/secondary_menu_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GrowColors.lightBg,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: ProfileHeaderWidget()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const MainMenuWidget(),
                const SizedBox(height: 40),
                const SecondaryMenuWidget(),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: GrowColors.lightSurface,
        selectedItemColor: GrowColors.lightTextPrimary,
        unselectedItemColor: GrowColors.lightTextSecondary,
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
          color: GrowColors.lightTextPrimary,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
          color: GrowColors.lightTextSecondary,
        ),
        currentIndex: 0, // Exemplo, 'Início' está selecionado
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Pedidos',
          ),
        ],
      ),
    );
  }
}
