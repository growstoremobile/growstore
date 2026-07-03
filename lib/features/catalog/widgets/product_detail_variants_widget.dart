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
      {'hex': '#0A0A0A', 'name': 'Preta'},
      {'hex': '#FFFFFF', 'name': 'Branca'},
    ],
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Observer(
      builder: (_) {
        final product = store.product;
        if (product == null) return const SizedBox();

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
                  color: colorScheme.onSurface,
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
                                  : colorScheme.onSurface,
                              width: isSelected ? 2 : 1.5,
                            ),
                          ),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              // Borda sutil só na bolinha branca
                              // para ela não sumir no fundo claro
                              border: colorHex == '#FFFFFF'
                                  ? Border.all(
                                      color: colorScheme.outline,
                                      width: 0.8,
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
                            color: colorScheme.onSurface,
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
                  color: colorScheme.onSurface,
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
                              ? GrowColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? GrowColors.primary
                                : colorScheme.onSurface,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          size,
                          style: textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? GrowColors.darkBg
                                : colorScheme.onSurface,
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
