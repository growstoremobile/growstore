import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/home/models/home_product_model.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';

class HomeProductGrid extends StatelessWidget {
  const HomeProductGrid({
    super.key,
    required this.products,
    required this.colors,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.onTap,
  });

  final List<HomeProductModel> products;
  final HomeLayoutColors colors;
  final bool Function(int productId) isFavorite;
  final ValueChanged<HomeProductModel> onFavoriteToggle;
  final ValueChanged<HomeProductModel> onAddToCart;
  final ValueChanged<HomeProductModel> onTap;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Container(
        color: colors.productGrid,
        constraints: const BoxConstraints(minHeight: 250),
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 64),
        alignment: Alignment.center,
        child: Text(
          'Nenhum produto nesta categoria',
          textAlign: TextAlign.center,
          style: GoogleFonts.syne(
            color: colors.productName,
            fontSize: 16,
            height: 22 / 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Container(
      color: colors.productGrid,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 12,
          childAspectRatio: 0.58,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return _HomeProductCard(
            product: product,
            colors: colors,
            isFavorite: isFavorite(product.id),
            onFavoriteToggle: () => onFavoriteToggle(product),
            onAddToCart: () => onAddToCart(product),
            onTap: () => onTap(product),
          );
        },
      ),
    );
  }
}

class _HomeProductCard extends StatelessWidget {
  const _HomeProductCard({
    required this.product,
    required this.colors,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.onTap,
  });

  final HomeProductModel product;
  final HomeLayoutColors colors;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonSurface = isDark
        ? const Color(0xDD0F1B2A)
        : Colors.white.withValues(alpha: .94);
    final mutedText = isDark
        ? const Color(0xFFBACCB0)
        : const Color(0xFF5A6658);

    return Material(
      color: colors.productCard,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: colors.productCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.productBorder),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 161 / 160,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _ProductImage(product: product, colors: colors),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _ProductActionButton(
                          tooltip: isFavorite
                              ? 'Remover dos favoritos'
                              : 'Adicionar aos favoritos',
                          icon: isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          iconColor: isFavorite ? colors.primary : mutedText,
                          backgroundColor: buttonSurface,
                          borderColor: colors.productBorder,
                          onPressed: onFavoriteToggle,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: _ProductActionButton(
                          tooltip: 'Comprar',
                          icon: Icons.add_shopping_cart_rounded,
                          iconColor: Colors.white,
                          backgroundColor: colors.primary,
                          borderColor: colors.primary,
                          onPressed: onAddToCart,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.category.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.jetBrainsMono(
                            color: mutedText,
                            fontSize: 10,
                            height: 12 / 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.syne(
                            color: colors.productName,
                            fontSize: 15,
                            height: 20 / 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          product.price,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.syne(
                            color: colors.primary,
                            fontSize: 24,
                            height: 22 / 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product, required this.colors});

  final HomeProductModel product;
  final HomeLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    if (product.asset.isEmpty) {
      return ColoredBox(
        color: colors.productGrid,
        child: Icon(
          Icons.inventory_2_outlined,
          color: colors.primary,
          size: 42,
        ),
      );
    }

    if (product.hasRemoteImage) {
      return Container(
        color: colors.productGrid,
        padding: const EdgeInsets.all(12),
        child: Image.network(
          product.asset,
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => Icon(
            Icons.broken_image_outlined,
            color: colors.primary,
            size: 42,
          ),
        ),
      );
    }

    return Image.asset(product.asset, fit: BoxFit.cover);
  }
}

class _ProductActionButton extends StatelessWidget {
  const _ProductActionButton({
    required this.tooltip,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 20),
          ),
        ),
      ),
    );
  }
}
