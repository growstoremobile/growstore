import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/catalog/stores/product_detail_store.dart';

class ProductDetailVariantsWidget extends StatelessWidget {
  final List<String> sizes;
  final List<Map<String, String>> colors;
  final ProductDetailStore store;

  const ProductDetailVariantsWidget({
    super.key,
    required this.store,
    this.sizes = const ['P', 'M', 'G', 'GG', 'XG'],
    this.colors = const [
      {'hex': '#0A0A0A', 'name': 'Preto'},
      {'hex': '#FFFFFF', 'name': 'Branco'},
    ],
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Observer(
      builder: (_) {
        final product = store.product;
        if (product == null) return const SizedBox();

        // Usa o getter da Store para consistência com addToCart
        final hasColorOptions = store.hasColorOptions;
        final hasSizeOptions = product.hasSizeOptions;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Seção de Cores ──
            if (hasColorOptions && colors.isNotEmpty) ...[
              Text(
                'Cor',
                style: textTheme.bodyMedium?.copyWith(
                  color: GrowColors.darkTextSecondary,
                  fontWeight: GrowTypography.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                children: colors.map((colorMap) {
                  final colorHex = colorMap['hex']!;
                  final colorName = colorMap['name']!;
                  final color = Color(
                    int.parse(colorHex.replaceFirst('#', '0xFF')),
                  );
                  final isSelected = store.selectedColor == colorHex;

                  return GestureDetector(
                    onTap: () => store.selectColor(colorHex),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? GrowColors.primary
                                  : GrowColors.darkBorder,
                              width: isSelected ? 2 : 1.5,
                            ),
                          ),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: colorHex == '#FFFFFF'
                                  ? Border.all(
                                      color: GrowColors.darkBorder,
                                      width: 0.5,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          colorName,
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            color: isSelected
                                ? GrowColors.darkTextPrimary
                                : GrowColors.darkTextSecondary,
                            fontWeight: isSelected
                                ? GrowTypography.bold
                                : GrowTypography.regular,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],

            // ── Seção de Tamanhos ──
            if (hasSizeOptions && sizes.isNotEmpty) ...[
              Text(
                'Tamanho',
                style: textTheme.bodyMedium?.copyWith(
                  color: GrowColors.darkTextSecondary,
                  fontWeight: GrowTypography.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: sizes.map((size) {
                  final isSelected = store.selectedSize == size;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => store.selectSize(size),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? GrowColors.primary.withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? GrowColors.darkBorderHighlight
                                : GrowColors.darkBorder,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          size,
                          style: textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? GrowColors.darkTextPrimary
                                : GrowColors.darkTextSecondary,
                            fontWeight: GrowTypography.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
          ],
        );
      },
    );
  }
}
