import 'package:flutter/material.dart';

class OrderLayoutColors {
  const OrderLayoutColors({
    required this.isDark,
    required this.primary,
    required this.statusBar,
    required this.header,
    required this.page,
    required this.bottomBar,
    required this.divider,
    required this.card,
    required this.cardBorder,
    required this.textPrimary,
    required this.textSecondary,
    required this.imageBackground,
    required this.chipBackground,
  });

  final bool isDark;
  final Color primary;
  final Color statusBar;
  final Color header;
  final Color page;
  final Color bottomBar;
  final Color divider;
  final Color card;
  final Color cardBorder;
  final Color textPrimary;
  final Color textSecondary;
  final Color imageBackground;
  final Color chipBackground;

  static OrderLayoutColors resolve(bool isDark) {
    const primary = Color(0xFF40A937);

    if (isDark) {
      return const OrderLayoutColors(
        isDark: true,
        primary: primary,
        statusBar: Color(0xFF0D1421),
        header: Color(0xFF0D1421),
        page: Color(0xFF04090F),
        bottomBar: Color(0xFF0F1B2A),
        divider: Color(0xFF0C3A19),
        card: Color(0xFF04090F),
        cardBorder: Color(0xFF0C3A19),
        textPrimary: Color(0xFFE2E3DF),
        textSecondary: Color(0xFF9AA2AB),
        imageBackground: Colors.white,
        chipBackground: Color(0xFF123F1C),
      );
    }

    return const OrderLayoutColors(
      isDark: false,
      primary: primary,
      statusBar: primary,
      header: primary,
      page: Color(0xFFF8F9FA),
      bottomBar: Color(0xFFE7E8E9),
      divider: Color(0xFFB8DDB9),
      card: Color(0x1A40A937),
      cardBorder: Color(0xFFA8DDA8),
      textPrimary: Color(0xFF191C1D),
      textSecondary: Color(0xFF6F767D),
      imageBackground: Colors.white,
      chipBackground: Color(0xFFC5E7C6),
    );
  }
}
