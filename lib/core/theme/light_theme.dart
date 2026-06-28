import 'package:flutter/material.dart';

import 'colors_theme.dart';
import 'typography_theme.dart';
import 'text_theme.dart';

final ThemeData growLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  colorScheme: const ColorScheme.light(
    primary: GrowColors.primary,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFC8E6C5),
    onPrimaryContainer: Color(0xFF1A3D18),
    secondary: GrowColors.badgeBestSeller,
    onSecondary: Colors.white,
    error: GrowColors.error,
    onError: Colors.white,
    surface: GrowColors.lightSurface,
    onSurface: GrowColors.lightTextPrimary,
    surfaceContainerHighest: GrowColors.lightSurfaceElevated,
    outline: GrowColors.lightBorder,
    outlineVariant: GrowColors.lightBorderHighlight,
  ),

  scaffoldBackgroundColor: GrowColors.lightBg,

  appBarTheme: AppBarTheme(
    backgroundColor: GrowColors.lightBg,
    foregroundColor: GrowColors.lightTextPrimary,
    elevation: 0,
    scrolledUnderElevation: 1,
    shadowColor: GrowColors.lightBorder.withValues(alpha: 0.4),
    centerTitle: false,
    titleTextStyle: const TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: 20,
      fontWeight: GrowTypography.heavy,
      color: GrowColors.lightTextPrimary,
      letterSpacing: 0.5,
    ),
    iconTheme: const IconThemeData(color: GrowColors.lightTextPrimary),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: GrowColors.lightSurface,
    selectedItemColor: GrowColors.primary,
    unselectedItemColor: GrowColors.lightTextSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 4,
    selectedLabelStyle: TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: 11,
      fontWeight: GrowTypography.bold,
      letterSpacing: 0.3,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: 11,
      fontWeight: GrowTypography.medium,
    ),
  ),

  cardTheme: CardThemeData(
    color: GrowColors.lightSurface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: GrowColors.lightBorder, width: 1),
    ),
    margin: EdgeInsets.zero,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: GrowColors.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: GrowColors.lightBorder,
      disabledForegroundColor: GrowColors.lightTextDisabled,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      textStyle: const TextStyle(
        fontFamily: GrowTypography.fontFamily,
        fontFamilyFallback: GrowTypography.fontFamilyFallback,
        fontSize: GrowTypography.labelLarge,
        fontWeight: GrowTypography.heavy,
        letterSpacing: 1.2,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: GrowColors.primary,
      side: const BorderSide(color: GrowColors.primary, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      textStyle: const TextStyle(
        fontFamily: GrowTypography.fontFamily,
        fontFamilyFallback: GrowTypography.fontFamilyFallback,
        fontSize: GrowTypography.labelLarge,
        fontWeight: GrowTypography.bold,
        letterSpacing: 1.0,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: GrowColors.primary,
      textStyle: const TextStyle(
        fontFamily: GrowTypography.fontFamily,
        fontFamilyFallback: GrowTypography.fontFamilyFallback,
        fontSize: GrowTypography.bodyLarge,
        fontWeight: GrowTypography.bold,
        letterSpacing: 0.5,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: GrowColors.lightSurfaceElevated,
    hintStyle: const TextStyle(
      color: GrowColors.lightTextDisabled,
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.bodyLarge,
    ),
    labelStyle: const TextStyle(
      color: GrowColors.lightTextSecondary,
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: GrowColors.lightBorder, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: GrowColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: GrowColors.error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: GrowColors.error, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: Colors.transparent,
    selectedColor: GrowColors.primary,
    disabledColor: GrowColors.lightBorder,
    labelStyle: const TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.bodyLarge,
      fontWeight: GrowTypography.bold,
    ),
    side: const BorderSide(color: GrowColors.lightBorder, width: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    showCheckmark: false,
  ),

  dividerTheme: const DividerThemeData(
    color: GrowColors.lightBorder,
    thickness: 1,
    space: 1,
  ),

  iconTheme: const IconThemeData(color: GrowColors.lightTextPrimary, size: 24),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: GrowColors.lightTextPrimary,
    contentTextStyle: const TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      color: GrowColors.lightSurface,
      fontSize: GrowTypography.bodyLarge,
    ),
    actionTextColor: GrowColors.primary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),

  badgeTheme: const BadgeThemeData(
    backgroundColor: GrowColors.primary,
    textColor: Colors.white,
    smallSize: 8,
    largeSize: 16,
  ),

  textTheme: buildGrowTextTheme(
    GrowColors.lightTextPrimary,
    GrowColors.lightTextSecondary,
  ),
);
