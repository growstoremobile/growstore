import 'package:flutter/material.dart';

import 'colors_theme.dart';
import 'typography_theme.dart';
import 'text_theme.dart';

final ThemeData growStoreDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  colorScheme: const ColorScheme.dark(
    primary: GrowStoreColors.primary,
    onPrimary: GrowStoreColors.darkBg,
    primaryContainer: Color(0xFF1A3D18),
    onPrimaryContainer: GrowStoreColors.primary,
    secondary: GrowStoreColors.badgeBestSeller,
    onSecondary: Colors.white,
    error: GrowStoreColors.error,
    onError: Colors.white,
    surface: GrowStoreColors.darkSurface,
    onSurface: GrowStoreColors.darkTextPrimary,
    surfaceContainerHighest: GrowStoreColors.darkSurfaceElevated,
    outline: GrowStoreColors.darkBorder,
    outlineVariant: GrowStoreColors.darkBorderHighlight,
  ),

  scaffoldBackgroundColor: GrowStoreColors.darkBg,

  appBarTheme: const AppBarTheme(
    backgroundColor: GrowStoreColors.darkBg,
    foregroundColor: GrowStoreColors.darkTextPrimary,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: 20,
      fontWeight: GrowStoreTypography.heavy,
      color: GrowStoreColors.darkTextPrimary,
      letterSpacing: 0.5,
    ),
    iconTheme: IconThemeData(color: GrowStoreColors.darkTextPrimary),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: GrowStoreColors.darkSurface,
    selectedItemColor: GrowStoreColors.primary,
    unselectedItemColor: GrowStoreColors.darkTextSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    selectedLabelStyle: TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: 11,
      fontWeight: GrowStoreTypography.bold,
      letterSpacing: 0.3,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: 11,
      fontWeight: GrowStoreTypography.medium,
    ),
  ),

  cardTheme: CardThemeData(
    color: GrowStoreColors.darkSurface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: GrowStoreColors.darkBorder, width: 1),
    ),
    margin: EdgeInsets.zero,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: GrowStoreColors.primary,
      foregroundColor: GrowStoreColors.darkBg,
      disabledBackgroundColor: GrowStoreColors.darkBorder,
      disabledForegroundColor: GrowStoreColors.darkTextDisabled,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      textStyle: const TextStyle(
        fontFamily: GrowStoreTypography.fontFamily,
        fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
        fontSize: GrowStoreTypography.labelLarge,
        fontWeight: GrowStoreTypography.heavy,
        letterSpacing: 1.2,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: GrowStoreColors.primary,
      side: const BorderSide(color: GrowStoreColors.primary, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      textStyle: const TextStyle(
        fontFamily: GrowStoreTypography.fontFamily,
        fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
        fontSize: GrowStoreTypography.labelLarge,
        fontWeight: GrowStoreTypography.bold,
        letterSpacing: 1.0,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: GrowStoreColors.primary,
      textStyle: const TextStyle(
        fontFamily: GrowStoreTypography.fontFamily,
        fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
        fontSize: GrowStoreTypography.bodyLarge,
        fontWeight: GrowStoreTypography.bold,
        letterSpacing: 0.5,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: GrowStoreColors.darkSurfaceElevated,
    hintStyle: const TextStyle(
      color: GrowStoreColors.darkTextDisabled,
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.bodyLarge,
    ),
    labelStyle: const TextStyle(
      color: GrowStoreColors.darkTextSecondary,
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: GrowStoreColors.darkBorder, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: GrowStoreColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: GrowStoreColors.error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: GrowStoreColors.error, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: Colors.transparent,
    selectedColor: GrowStoreColors.primary,
    disabledColor: GrowStoreColors.darkBorder,
    labelStyle: const TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.bodyLarge,
      fontWeight: GrowStoreTypography.bold,
    ),
    side: const BorderSide(color: GrowStoreColors.darkBorder, width: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    showCheckmark: false,
  ),

  dividerTheme: const DividerThemeData(
    color: GrowStoreColors.darkBorder,
    thickness: 1,
    space: 1,
  ),

  iconTheme: const IconThemeData(
    color: GrowStoreColors.darkTextPrimary,
    size: 24,
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: GrowStoreColors.darkSurfaceElevated,
    contentTextStyle: const TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      color: GrowStoreColors.darkTextPrimary,
      fontSize: GrowStoreTypography.bodyLarge,
    ),
    actionTextColor: GrowStoreColors.primary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),

  badgeTheme: const BadgeThemeData(
    backgroundColor: GrowStoreColors.primary,
    textColor: GrowStoreColors.darkBg,
    smallSize: 8,
    largeSize: 16,
  ),

  textTheme: buildGrowTextTheme(
    GrowStoreColors.darkTextPrimary,
    GrowStoreColors.darkTextSecondary,
  ),
);
