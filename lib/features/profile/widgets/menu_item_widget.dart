import 'package:flutter/material.dart';
import 'package:growstore/core/theme/growstore_theme.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Icon(icon, size: 22, color: GrowColors.lightTextPrimary),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: GrowColors.lightTextPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
