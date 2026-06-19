import 'package:flutter/material.dart';

import '../../theme/colors_theme.dart';
import '../../theme/typography_theme.dart';

/// Widget de estado vazio — exibido quando não há conteúdo para mostrar.
///
/// Usage:
/// ```dart
/// // Carrinho vazio
/// GrowEmptyState(
///   icon: Icons.shopping_cart_outlined,
///   title: 'Seu carrinho está vazio',
///   description: 'Adicione produtos para continuar.',
///   actionLabel: 'Explorar loja',
///   onAction: () => Navigator.pop(context),
/// )
///
/// // Sem resultados de busca
/// GrowEmptyState(
///   icon: Icons.search_off_rounded,
///   title: 'Nenhum resultado encontrado',
///   description: 'Tente buscar com outras palavras.',
/// )
/// ```

class GrowEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;

  /// Label do botão de ação. Se nulo, o botão não é exibido.
  final String? actionLabel;
  final VoidCallback? onAction;

  const GrowEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconBgColor = isDark
        ? GrowColors.darkSurfaceElevated
        : GrowColors.lightSurfaceElevated;
    final descriptionColor = isDark
        ? GrowColors.darkTextSecondary
        : GrowColors.lightTextSecondary;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ícone
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36, color: GrowColors.primary),
            ),

            const SizedBox(height: 24),

            // Título
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: GrowTypography.fontFamily,
                fontFamilyFallback: GrowTypography.fontFamilyFallback,
                fontSize: GrowTypography.titleLarge,
                fontWeight: GrowTypography.bold,
                color: isDark
                    ? GrowColors.darkTextPrimary
                    : GrowColors.lightTextPrimary,
              ),
            ),

            // Descrição
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: GrowTypography.fontFamily,
                  fontFamilyFallback: GrowTypography.fontFamilyFallback,
                  fontSize: GrowTypography.bodyLarge,
                  fontWeight: GrowTypography.regular,
                  height: 1.5,
                  color: descriptionColor,
                ),
              ),
            ],

            // Botão de ação
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onAction,
                  child: Text(actionLabel!.toUpperCase()),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
