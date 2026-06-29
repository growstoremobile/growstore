import 'package:flutter/material.dart';

import 'colors_theme.dart';
import 'typography_theme.dart';

TextTheme buildGrowTextTheme(Color primary, Color secondary) {
  return TextTheme(
    displayLarge: TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.displayLarge,
      fontWeight: GrowTypography.heavy,
      letterSpacing: -0.5,
      height: 1.1,
      color: primary,
    ),

    displayMedium: TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.displayMedium,
      fontWeight: GrowTypography.heavy,
      letterSpacing: 0,
      height: 1.15,
      color: primary,
    ),

    titleLarge: TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.titleLarge,
      fontWeight: GrowTypography.bold,
      letterSpacing: 0.2,
      color: primary,
    ),
    titleMedium: TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.titleMedium,
      fontWeight: GrowTypography.bold,
      letterSpacing: 0.5,
      color: primary,
    ),

    bodyLarge: TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.bodyLarge,
      fontWeight: GrowTypography.regular,
      height: 1.5,
      color: secondary,
    ),
    bodyMedium: TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.bodyMedium,
      fontWeight: GrowTypography.regular,
      height: 1.4,
      color: secondary,
    ),

    labelLarge: const TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.labelLarge,
      fontWeight: GrowTypography.bold,
      letterSpacing: 1.2,
      color: GrowColors.darkBg,
    ),

    labelSmall: const TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.labelSmall,
      fontWeight: GrowTypography.heavy,
      letterSpacing: 0.8,
      color: Colors.white,
    ),
  );
}

extension GrowTextStyles on TextTheme {
  TextStyle get priceStyle => const TextStyle(
    fontFamily: GrowTypography.fontFamilyPrice,
    fontFamilyFallback: GrowTypography.fontFamilyPriceFallback,
    fontSize: 20,
    fontWeight: GrowTypography.bold,
    color: GrowColors.primary,
    letterSpacing: -0.5,
  );

  TextStyle get priceTotalStyle => const TextStyle(
    fontFamily: GrowTypography.fontFamilyPrice,
    fontFamilyFallback: GrowTypography.fontFamilyPriceFallback,
    fontSize: 36,
    fontWeight: GrowTypography.bold,
    color: GrowColors.primary,
    letterSpacing: -1,
  );
}
