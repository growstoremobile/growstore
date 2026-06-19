import 'package:flutter/material.dart';

import '../../theme/colors_theme.dart';
import '../../theme/typography_theme.dart';

/// Widget de estado de erro.
///
/// Usage:
/// ```dart
/// // Erro genérico com retry
/// GrowErrorState(
///   onRetry: () => ref.refresh(productsProvider),
/// )
///
/// // Erro de conexão
/// GrowErrorState(
///   type: GrowErrorType.network,
///   onRetry: () => fetchProducts(),
/// )
///
/// // Erro customizado
/// GrowErrorState(
///   type: GrowErrorType.custom,
///   title: 'Pagamento recusado',
///   description: 'Verifique os dados do cartão e tente novamente.',
///   onRetry: () => retryPayment(),
/// )
/// ```

enum GrowErrorType { generic, network, custom }

class GrowErrorState extends StatelessWidget {
  final GrowErrorType type;

  /// Usado apenas quando [type] é [GrowErrorType.custom].
  final String? title;

  /// Usado apenas quando [type] é [GrowErrorType.custom].
  final String? description;

  /// Label do botão de retry. Padrão: "Tentar novamente".
  final String? retryLabel;

  /// Callback do botão de retry. Se nulo, o botão não é exibido.
  final VoidCallback? onRetry;

  const GrowErrorState({
    super.key,
    this.type = GrowErrorType.generic,
    this.title,
    this.description,
    this.retryLabel,
    this.onRetry,
  });

  // Conteúdo por tipo

  String _resolveTitle() {
    return switch (type) {
      GrowErrorType.generic => 'Algo deu errado',
      GrowErrorType.network => 'Sem conexão',
      GrowErrorType.custom => title ?? 'Algo deu errado',
    };
  }

  String _resolveDescription() {
    return switch (type) {
      GrowErrorType.generic =>
        'Ocorreu um erro inesperado.\nTente novamente em instantes.',
      GrowErrorType.network =>
        'Verifique sua conexão com a internet\ne tente novamente.',
      GrowErrorType.custom => description ?? '',
    };
  }

  IconData _resolveIcon() {
    return switch (type) {
      GrowErrorType.generic => Icons.error_outline_rounded,
      GrowErrorType.network => Icons.wifi_off_rounded,
      GrowErrorType.custom => Icons.warning_amber_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconBgColor = isDark
        ? GrowColors.darkSurfaceElevated
        : GrowColors.lightSurfaceElevated;
    final titleColor = isDark
        ? GrowColors.darkTextPrimary
        : GrowColors.lightTextPrimary;
    final descriptionColor = isDark
        ? GrowColors.darkTextSecondary
        : GrowColors.lightTextSecondary;

    final resolvedDescription = _resolveDescription();

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
              child: Icon(_resolveIcon(), size: 36, color: GrowColors.error),
            ),

            const SizedBox(height: 24),

            // Título
            Text(
              _resolveTitle(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: GrowTypography.fontFamily,
                fontFamilyFallback: GrowTypography.fontFamilyFallback,
                fontSize: GrowTypography.titleLarge,
                fontWeight: GrowTypography.bold,
                color: titleColor,
              ),
            ),

            // Descrição
            if (resolvedDescription.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                resolvedDescription,
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

            // Botão retry
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text((retryLabel ?? 'Tentar novamente').toUpperCase()),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
