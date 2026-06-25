import 'package:flutter/material.dart';

class ThemeModeController extends InheritedWidget {
  const ThemeModeController({
    super.key,
    required this.themeMode,
    required this.toggleTheme,
    required super.child,
  });

  final ThemeMode themeMode;
  final ValueChanged<Brightness> toggleTheme;

  static ThemeModeController of(BuildContext context) {
    final controller = context
        .dependOnInheritedWidgetOfExactType<ThemeModeController>();

    assert(controller != null, 'ThemeModeController not found in context.');
    return controller!;
  }

  @override
  bool updateShouldNotify(ThemeModeController oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
