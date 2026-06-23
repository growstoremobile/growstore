// TODO: Widget implementado e pronto para uso.
// O design aprovado da PDP não exibe seletor de variantes de cor e tamanho nesta tela.
// A seleção de tamanho/cor ocorre na tela do Carrinho (Quem for implementar utilizar esse widget aqui).
// Remover este TODO quando o fluxo completo for definido pelo time.

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/catalog/stores/product_detail_store.dart';

class ProductDetailVariantsWidget extends StatelessWidget {
  final List<String> sizes;
  final List<String> colors;

  const ProductDetailVariantsWidget({
    super.key,
    this.sizes = const [],
    this.colors = const [],
  });

  @override
  Widget build(BuildContext context) {
    final store = GetIt.I.get<ProductDetailStore>();
    final textTheme = Theme.of(context).textTheme;

    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Tamanhos ──
            if (sizes.isNotEmpty) ...[
              Text(
                'Tamanho',
                style: textTheme.bodyMedium?.copyWith(
                  color: GrowColors.darkTextPrimary,
                  fontWeight: GrowTypography.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: sizes.map((size) {
                  final isSelected = store.selectedSize == size;
                  return GestureDetector(
                    onTap: () => store.selectSize(size),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? GrowColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? GrowColors.primary
                              : GrowColors.darkBorder,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        size,
                        style: textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? GrowColors.darkBg
                              : GrowColors.darkTextSecondary,
                          fontWeight: GrowTypography.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],

            // ── Cores ──
            if (colors.isNotEmpty) ...[
              Text(
                'Cor',
                style: textTheme.bodyMedium?.copyWith(
                  color: GrowColors.darkTextPrimary,
                  fontWeight: GrowTypography.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: colors.map((colorHex) {
                  final color = Color(
                    int.parse(colorHex.replaceFirst('#', '0xFF')),
                  );
                  final isSelected = store.selectedColor == colorHex;
                  return GestureDetector(
                    onTap: () => store.selectColor(colorHex),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? GrowColors.primary
                              : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: GrowColors.primary.withValues(
                                    alpha: 0.5,
                                  ),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ]
                            : [],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
