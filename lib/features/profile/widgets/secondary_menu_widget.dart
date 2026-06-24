import 'package:flutter/material.dart';
import 'package:growstore/features/profile/widgets/menu_item_widget.dart';

class SecondaryMenuWidget extends StatelessWidget {
  final VoidCallback onLogout;

  const SecondaryMenuWidget({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MenuItemWidget(
          icon: Icons.settings_outlined,
          title: 'Configurações',
        ),
        MenuItemWidget(icon: Icons.logout, title: 'Sair', onTap: onLogout),
      ],
    );
  }
}
