import 'package:flutter/material.dart';

import 'colors_theme.dart';
import 'typography_theme.dart';

TextTheme buildGrowTextTheme(Color primary, Color secondary) {
  // Fonte Inter
  return TextTheme(
    // Títulos principais
    displayLarge: TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.displayLarge,
      fontWeight: GrowStoreTypography.heavy,
      letterSpacing: -0.5,
      height: 1.1,
      color: primary,
    ),

    // Títulos da secção
    displayMedium: TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.displayMedium,
      fontWeight: GrowStoreTypography.heavy,
      letterSpacing: 0,
      height: 1.15,
      color: primary,
    ),

    // Nome do produto
    titleLarge: TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.titleLarge,
      fontWeight: GrowStoreTypography.bold,
      letterSpacing: 0.2,
      color: primary,
    ),
    titleMedium: TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.titleMedium,
      fontWeight: GrowStoreTypography.bold,
      letterSpacing: 0.5,
      color: primary,
    ),

    // Texto principal
    bodyLarge: TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.bodyLarge,
      fontWeight: GrowStoreTypography.regular,
      height: 1.5,
      color: secondary,
    ),
    bodyMedium: TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.bodyMedium,
      fontWeight: GrowStoreTypography.regular,
      height: 1.4,
      color: secondary,
    ),

    // Buttons
    labelLarge: TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.labelLarge,
      fontWeight: GrowStoreTypography.bold,
      letterSpacing: 1.2,
      color: GrowStoreColors.darkBg,
    ),

    // Etiquetas
    labelSmall: TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.labelSmall,
      fontWeight: GrowStoreTypography.heavy,
      letterSpacing: 0.8,
      color: Colors.white,
    ),
  );
}

// Fonte Syne
extension GrowStoreTextStyles on TextTheme {
  // "R$ 499,00" – preço do produto
  TextStyle get priceStyle => const TextStyle(
    fontFamily: GrowStoreTypography.fontFamilyPrice,
    fontFamilyFallback: GrowStoreTypography.fontFamilyPriceFallback,
    fontSize: 20,
    fontWeight: GrowStoreTypography.bold,
    color: GrowStoreColors.primary,
    letterSpacing: -0.5,
  );

  // "R$ 797,30" – Total do carrinho (extra grande)
  TextStyle get priceTotalStyle => const TextStyle(
    fontFamily: GrowStoreTypography.fontFamilyPrice,
    fontFamilyFallback: GrowStoreTypography.fontFamilyPriceFallback,
    fontSize: 36,
    fontWeight: GrowStoreTypography.bold,
    color: GrowStoreColors.primary,
    letterSpacing: -1,
  );
}
