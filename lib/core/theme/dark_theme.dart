import 'package:flutter/material.dart';

import 'colors_theme.dart';
import 'typography_theme.dart';
import 'text_theme.dart';

final ThemeData growDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  colorScheme: const ColorScheme.dark(
    primary: GrowColors.primary,
    onPrimary: GrowColors.darkBg,
    primaryContainer: Color(0xFF1A3D18),
    onPrimaryContainer: GrowColors.primary,
    secondary: GrowColors.badgeBestSeller,
    onSecondary: Colors.white,
    error: GrowColors.error,
    onError: Colors.white,
    surface: GrowColors.darkSurface,
    onSurface: GrowColors.darkTextPrimary,
    surfaceContainerHighest: GrowColors.darkSurfaceElevated,
    outline: GrowColors.darkBorder,
    outlineVariant: GrowColors.darkBorderHighlight,
  ),

  scaffoldBackgroundColor: GrowColors.darkBg,

  appBarTheme: const AppBarTheme(
    backgroundColor: GrowColors.darkBg,
    foregroundColor: GrowColors.darkTextPrimary,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: 20,
      fontWeight: GrowTypography.heavy,
      color: GrowColors.darkTextPrimary,
      letterSpacing: 0.5,
    ),
    iconTheme: IconThemeData(color: GrowColors.darkTextPrimary),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: GrowColors.darkSurface,
    selectedItemColor: GrowColors.primary,
    unselectedItemColor: GrowColors.darkTextSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
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

  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: GrowColors.darkSurfaceElevated,
    indicatorColor: GrowColors.primary,
  ),

  cardTheme: CardThemeData(
    color: GrowColors.darkSurface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: GrowColors.darkBorderHighlight, width: 1),
    ),
    margin: EdgeInsets.zero,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: GrowColors.primary,
      foregroundColor: GrowColors.darkBg,
      disabledBackgroundColor: GrowColors.darkBorder,
      disabledForegroundColor: GrowColors.darkTextDisabled,
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
    fillColor: GrowColors.darkSurfaceElevated,
    hintStyle: const TextStyle(
      color: GrowColors.darkTextDisabled,
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.bodyLarge,
    ),
    labelStyle: const TextStyle(
      color: GrowColors.darkTextSecondary,
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: GrowColors.darkBorder, width: 1),
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
    disabledColor: GrowColors.darkBorder,
    labelStyle: const TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      fontSize: GrowTypography.bodyLarge,
      fontWeight: GrowTypography.bold,
    ),
    side: const BorderSide(color: GrowColors.darkBorder, width: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    showCheckmark: false,
  ),

  dividerTheme: const DividerThemeData(
    color: GrowColors.darkBorder,
    thickness: 1,
    space: 1,
  ),

  iconTheme: const IconThemeData(color: GrowColors.darkTextPrimary, size: 24),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: GrowColors.darkSurfaceElevated,
    contentTextStyle: const TextStyle(
      fontFamily: GrowTypography.fontFamily,
      fontFamilyFallback: GrowTypography.fontFamilyFallback,
      color: GrowColors.darkTextPrimary,
      fontSize: GrowTypography.bodyLarge,
    ),
    actionTextColor: GrowColors.primary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),

  badgeTheme: const BadgeThemeData(
    backgroundColor: GrowColors.primary,
    textColor: GrowColors.darkBg,
    smallSize: 8,
    largeSize: 16,
  ),

  textTheme: buildGrowTextTheme(
    GrowColors.darkTextPrimary,
    GrowColors.darkTextSecondary,
  ),
);
