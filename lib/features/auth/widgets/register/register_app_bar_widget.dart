import 'package:flutter/material.dart';
import 'package:growstore/core/theme/theme_mode_controller.dart';
import 'package:growstore/shared/widgets/theme_toggle_button.dart';

class RegisterAppBarWidget extends StatelessWidget {
  const RegisterAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: isDark ? 0.92 : 0.96),
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withValues(
                alpha: isDark ? 0.32 : 0.18,
              ),
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 48,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: 'Voltar',
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.eco_rounded, color: colorScheme.primary, size: 24),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Grow Store',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 48,
              child: Center(
                child: ThemeToggleButton(
                  isDark: isDark,
                  onPressed: () => ThemeModeController.of(
                    context,
                  ).toggleTheme(theme.brightness),
                  borderColor: colorScheme.outline.withValues(
                    alpha: isDark ? 0.58 : 0.36,
                  ),
                  iconColor: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
