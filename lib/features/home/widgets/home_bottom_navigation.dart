import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key, required this.onTap});

  final ValueChanged<String> onTap;

  static const _items = [
    (Icons.home_filled, 'Início'),
    (Icons.grid_view_rounded, 'Categorias'),
    (Icons.shopping_cart_rounded, 'Carrinho'),
    (Icons.favorite_rounded, 'Favoritos'),
    (Icons.shopping_bag_rounded, 'Pedidos'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primary = Color(0xFF40A937);
    final background = isDark
        ? const Color(0xFF0F1B2A)
        : const Color(0xFFE7E8E9);
    final unselected = isDark
        ? const Color(0xFFE2E3DF)
        : const Color(0xFF191C1D);

    return Container(
      height: 83,
      padding: const EdgeInsets.fromLTRB(8, 7, 8, 8),
      decoration: BoxDecoration(
        color: background,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.transparent : const Color(0xFFC6C8C9),
          ),
        ),
      ),
      child: Row(
        children: _items.map((item) {
          final selected = item.$2 == 'Início';
          return Expanded(
            child: InkWell(
              onTap: () => onTap(item.$2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.$1,
                    color: selected ? primary : unselected,
                    size: 25,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.$2,
                    style: GoogleFonts.jetBrainsMono(
                      color: selected ? primary : unselected,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      height: 12 / 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
