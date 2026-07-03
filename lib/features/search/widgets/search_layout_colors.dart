import 'package:flutter/material.dart';

class SearchLayoutColors {
  const SearchLayoutColors({
    required this.primary,
    required this.page,
    required this.header,
    required this.headerBorder,
    required this.field,
    required this.fieldBorder,
    required this.textPrimary,
    required this.textSecondary,
    required this.card,
    required this.cardBorder,
    required this.imageBackground,
    required this.buttonForeground,
  });

  final Color primary;
  final Color page;
  final Color header;
  final Color headerBorder;
  final Color field;
  final Color fieldBorder;
  final Color textPrimary;
  final Color textSecondary;
  final Color card;
  final Color cardBorder;
  final Color imageBackground;
  final Color buttonForeground;

  static SearchLayoutColors resolve(bool isDark) {
    const primary = Color(0xFF40A937);

    if (isDark) {
      return const SearchLayoutColors(
        primary: primary,
        page: Color(0xFF04090F),
        header: Color(0xB80F1B2A),
        headerBorder: Color(0x1AFFFFFF),
        field: Color(0xFF04090F),
        fieldBorder: Color(0x1AFFFFFF),
        textPrimary: Color(0xFFE2E3DF),
        textSecondary: Color(0xFF7D848C),
        card: Color(0xB80F1B2A),
        cardBorder: Color(0x1AFFFFFF),
        imageBackground: Color(0xFF04090F),
        buttonForeground: Color(0xFF04090F),
      );
    }

    return const SearchLayoutColors(
      primary: primary,
      page: Color(0xFFF8F9FA),
      header: Color(0xFF40A937),
      headerBorder: Color(0xFFE7E8E9),
      field: Colors.white,
      fieldBorder: Colors.white,
      textPrimary: Color(0xFF191C1D),
      textSecondary: Color(0xFF7D848C),
      card: Color(0x1A40A937),
      cardBorder: Color(0x4D40A937),
      imageBackground: Colors.white,
      buttonForeground: Colors.white,
    );
  }
}
