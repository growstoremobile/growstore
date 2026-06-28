import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

// Estilo de card da tela de carrinho: fundo cinza claro + borda verde, como no
// Figma. Definido localmente na feature para não alterar a paleta global
// compartilhada (responsabilidade da tarefa de tema).
const Color cartCardColor = Color(0xFFEAEEEA);

class CartLayoutColors {
  const CartLayoutColors({
    required this.isDark,
    required this.statusBar,
    required this.header,
    required this.page,
    required this.bottomBar,
    required this.divider,
    required this.card,
    required this.cardBorder,
    required this.textPrimary,
    required this.textSecondary,
    required this.primary,
    required this.sizeChip,
    required this.sizeChipText,
    required this.sizeChipSelected,
    required this.sizeChipSelectedText,
    required this.quantityButton,
    required this.buttonText,
  });

  factory CartLayoutColors.resolve(bool isDark) {
    if (isDark) {
      return const CartLayoutColors(
        isDark: true,
        statusBar: Color(0xFF0D1421),
        header: Color(0xFF0D1421),
        page: Color(0xFF04090F),
        bottomBar: Color(0xFF0F1B2A),
        divider: Color(0xFF0C3A19),
        card: Color(0xFF04090F),
        cardBorder: Color(0x4D40A937),
        textPrimary: Color(0xFFE2E3DF),
        textSecondary: Color(0xFFE2E3DF),
        primary: Color(0xFF40A937),
        sizeChip: Color(0xFF123F1C),
        sizeChipText: Color(0xFF40A937),
        sizeChipSelected: Color(0xFF0AD70A),
        sizeChipSelectedText: Color(0xFF04090F),
        quantityButton: Color(0xFF123F1C),
        buttonText: Colors.white,
      );
    }

    return const CartLayoutColors(
      isDark: false,
      statusBar: Color(0xFF40A937),
      header: Color(0xFF40A937),
      page: Color(0xFFF8F9FA),
      bottomBar: Color(0xFFE7E8E9),
      divider: Colors.transparent,
      card: Color(0xFFE5F1E7),
      cardBorder: Color(0xFFB8DDB9),
      textPrimary: Color(0xFF191C1D),
      textSecondary: Color(0xFF191C1D),
      primary: Color(0xFF40A937),
      sizeChip: Color(0xFFC5E7C6),
      sizeChipText: Color(0xFF40A937),
      sizeChipSelected: Color(0xFFE5F1E7),
      sizeChipSelectedText: Color(0xFF191C1D),
      quantityButton: Color(0xFFC5E7C6),
      buttonText: Color(0xFF04090F),
    );
  }

  final bool isDark;
  final Color statusBar;
  final Color header;
  final Color page;
  final Color bottomBar;
  final Color divider;
  final Color card;
  final Color cardBorder;
  final Color textPrimary;
  final Color textSecondary;
  final Color primary;
  final Color sizeChip;
  final Color sizeChipText;
  final Color sizeChipSelected;
  final Color sizeChipSelectedText;
  final Color quantityButton;
  final Color buttonText;
}

BoxDecoration cartCardDecoration() {
  return BoxDecoration(
    color: cartCardColor,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: AppColors.growthGreen.withValues(alpha: 0.6),
      width: 1.5,
    ),
  );
}
