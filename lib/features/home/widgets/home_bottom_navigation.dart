import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key, required this.onTap});

  final ValueChanged<String> onTap;

  static const _items = [
    (Icons.home_filled, 'Home'),
    (Icons.storefront_outlined, 'Loja'),
    (Icons.shopping_cart_outlined, 'Carrinho'),
    (Icons.person_outline_rounded, 'Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF111412).withValues(alpha: .80),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: .10)),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A39FF14),
            offset: Offset(0, -4),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        children: _items.map((item) {
          final selected = item.$2 == 'Home';
          return Expanded(
            child: InkWell(
              onTap: () => onTap(item.$2),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: selected
                        ? const Color(0xFF39FF14)
                        : Colors.transparent,
                  ),
                  const Spacer(),
                  Icon(
                    item.$1,
                    color: selected
                        ? const Color(0xFF39FF14)
                        : const Color(0xFFBACCB0),
                    size: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.$2,
                    style: GoogleFonts.jetBrainsMono(
                      color: selected
                          ? const Color(0xFF39FF14)
                          : const Color(0xFFBACCB0),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 16 / 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
