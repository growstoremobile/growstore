import 'package:flutter/material.dart';
import 'package:growstore/core/theme/growstore_theme.dart';

class DefaultProductCard extends StatelessWidget {
  final String titleProduct;
  final IconData? iconButton;
  final IconData? iconFavority;
  final String? textButton;
  final String? pathImage;
  final double price;
  final VoidCallback? onPressed;

  const DefaultProductCard({
    super.key,
    required this.titleProduct,
    required this.price,
    this.pathImage,
    this.iconButton,
    this.iconFavority,
    this.textButton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(16),
      //   side: const BorderSide(color: Colors.green, width: 1),
      // ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: pathImage != null
                          ? (pathImage!.startsWith('http')
                                ? Image.network(
                                    pathImage!,
                                    fit: BoxFit.contain,
                                  ) // Se for link do Supabase
                                : Image.asset(
                                    pathImage!,
                                    fit: BoxFit.contain,
                                  )) // Se for asset local mockado
                          : const Placeholder(),
                    ),

                    // Favorito
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        iconFavority ?? Icons.favorite_border,
                        color: iconFavority == Icons.favorite
                            ? colors.primary
                            : theme.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Informações
            Container(
              decoration: BoxDecoration(color: colors.surfaceContainerHighest),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleProduct,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'R\$ ${price.toStringAsFixed(2)}',
                      style: theme.textTheme.priceStyle.copyWith(
                        color: colors.primary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: onPressed,
                        icon: Icon(iconButton ?? iconButton),
                        label: Text(textButton ?? ''),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
