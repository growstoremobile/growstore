import 'package:flutter/material.dart';
import 'package:growstore/features/profile/widgets/menu_item_widget.dart';

class SecondaryMenuWidget extends StatelessWidget {
  const SecondaryMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MenuItemWidget(icon: Icons.settings_outlined, title: 'Configurações'),
        MenuItemWidget(icon: Icons.logout, title: 'Sair'),
      ],
    );
  }
}
