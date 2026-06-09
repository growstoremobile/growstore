import 'package:flutter/material.dart';

import 'colors_theme.dart';
import 'typography_theme.dart';
import 'text_theme.dart';

final ThemeData growStoreLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  colorScheme: const ColorScheme.light(
    primary: GrowStoreColors.primaryDark,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFC8E6C5),
    onPrimaryContainer: Color(0xFF1A3D18),
    secondary: GrowStoreColors.badgeBestSeller,
    onSecondary: Colors.white,
    error: GrowStoreColors.error,
    onError: Colors.white,
    surface: GrowStoreColors.lightSurface,
    onSurface: GrowStoreColors.lightTextPrimary,
    surfaceContainerHighest: GrowStoreColors.lightSurfaceElevated,
    outline: GrowStoreColors.lightBorder,
    outlineVariant: GrowStoreColors.lightBorderHighlight,
  ),

  scaffoldBackgroundColor: GrowStoreColors.lightBg,

  appBarTheme: AppBarTheme(
    backgroundColor: GrowStoreColors.lightSurface,
    foregroundColor: GrowStoreColors.lightTextPrimary,
    elevation: 0,
    scrolledUnderElevation: 1,
    shadowColor: GrowStoreColors.lightBorder.withValues(alpha: 0.4),
    centerTitle: false,
    titleTextStyle: const TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: 20,
      fontWeight: GrowStoreTypography.heavy,
      color: GrowStoreColors.lightTextPrimary,
      letterSpacing: 0.5,
    ),
    iconTheme: const IconThemeData(color: GrowStoreColors.lightTextPrimary),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: GrowStoreColors.lightSurface,
    selectedItemColor: GrowStoreColors.primaryDark,
    unselectedItemColor: GrowStoreColors.lightTextSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 4,
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
    color: GrowStoreColors.lightSurface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: GrowStoreColors.lightBorder, width: 1),
    ),
    margin: EdgeInsets.zero,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: GrowStoreColors.primaryDark,
      foregroundColor: Colors.white,
      disabledBackgroundColor: GrowStoreColors.lightBorder,
      disabledForegroundColor: GrowStoreColors.lightTextDisabled,
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
      foregroundColor: GrowStoreColors.primaryDark,
      side: const BorderSide(color: GrowStoreColors.primaryDark, width: 1.5),
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
      foregroundColor: GrowStoreColors.primaryDark,
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
    fillColor: GrowStoreColors.lightSurfaceElevated,
    hintStyle: const TextStyle(
      color: GrowStoreColors.lightTextDisabled,
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.bodyLarge,
    ),
    labelStyle: const TextStyle(
      color: GrowStoreColors.lightTextSecondary,
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: GrowStoreColors.lightBorder,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: GrowStoreColors.primaryDark,
        width: 1.5,
      ),
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
    selectedColor: GrowStoreColors.primaryDark,
    disabledColor: GrowStoreColors.lightBorder,
    labelStyle: const TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      fontSize: GrowStoreTypography.bodyLarge,
      fontWeight: GrowStoreTypography.bold,
    ),
    side: const BorderSide(color: GrowStoreColors.lightBorder, width: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    showCheckmark: false,
  ),

  dividerTheme: const DividerThemeData(
    color: GrowStoreColors.lightBorder,
    thickness: 1,
    space: 1,
  ),

  iconTheme: const IconThemeData(
    color: GrowStoreColors.lightTextPrimary,
    size: 24,
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: GrowStoreColors.lightTextPrimary,
    contentTextStyle: const TextStyle(
      fontFamily: GrowStoreTypography.fontFamily,
      fontFamilyFallback: GrowStoreTypography.fontFamilyFallback,
      color: GrowStoreColors.lightSurface,
      fontSize: GrowStoreTypography.bodyLarge,
    ),
    actionTextColor: GrowStoreColors.primary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),

  badgeTheme: const BadgeThemeData(
    backgroundColor: GrowStoreColors.primaryDark,
    textColor: Colors.white,
    smallSize: 8,
    largeSize: 16,
  ),

  textTheme: buildGrowTextTheme(
    GrowStoreColors.lightTextPrimary,
    GrowStoreColors.lightTextSecondary,
  ),
);
