import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/auth/pages/login_page.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/profile/widgets/main_menu_widget.dart';
import 'package:growstore/features/profile/widgets/profile_header_widget.dart';
import 'package:growstore/features/profile/widgets/secondary_menu_widget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final _authStore = GetIt.I.get<AuthStore>();
  final _cartStore = GetIt.I.get<CartStore>();

  void _handleLogout(BuildContext context) {
    // Limpa o estado global
    _authStore.logout();
    // Limpa o estado global do carrinho
    _cartStore.clearCart();

    // Navega para a tela de login e remove todas as outras da pilha
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GrowColors.lightBg,
      body: Observer(
        builder: (_) {
          final userName = _authStore.user?.name ?? 'Visitante';

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ProfileHeaderWidget(userName: userName),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const MainMenuWidget(),
                    const SizedBox(height: 50),
                    SecondaryMenuWidget(onLogout: () => _handleLogout(context)),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
