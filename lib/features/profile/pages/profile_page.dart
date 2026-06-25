import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/auth/repositories/auth_repository.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/profile/widgets/main_menu_widget.dart';
import 'package:growstore/features/profile/widgets/profile_header_widget.dart';
import 'package:growstore/features/profile/widgets/secondary_menu_widget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final _authStore = GetIt.I.get<AuthStore>();

  Future<void> _handleLogout(BuildContext context) async {
    await AuthRepository().logout();
    _authStore.logout();

    if (GetIt.I.isRegistered<CartStore>()) {
      GetIt.I<CartStore>().clearCart();
    }

    if (!context.mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
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
