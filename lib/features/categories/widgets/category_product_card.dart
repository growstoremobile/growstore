zimport 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/categories/widgets/category_layout_colors.dart';
import 'package:growstore/shared/widgets/cached_product_image.dart';

class CategoryProductCard extends StatelessWidget {
  const CategoryProductCard({
    super.key,
    required this.product,
    required this.colors,
    required this.onTap,
    this.isFavorite = false,
    this.onFavorite,
  });

  final Map<String, dynamic> product;
  final CategoryLayoutColors colors;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback? onFavorite;

  String get _title => (product['title'] ?? 'Produto').toString();
  String get _image => (product['image'] ?? '').toString();

  @override
  Widget build(BuildContext context) {
    final price = _parsePrice(product['price'] ?? product['price_product']);

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
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ColoredBox(color: colors.productImage),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: GrowCachedProductImage(
                          imageUrl: _image,
                          backgroundColor: colors.productImage,
                          iconColor: colors.primary,
                          fit: BoxFit.contain,
                          cacheWidth: 420,
                          cacheHeight: 420,
                        ),
                      ),
                      Positioned(
                        top: 7,
                        right: 7,
                        child: _FavoriteButton(
                          colors: colors,
                          selected: isFavorite,
                          onPressed: onFavorite,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 74,
                  color: colors.productInfo,
                  padding: const EdgeInsets.fromLTRB(8, 9, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: colors.categoryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 17 / 14,
                        ),
                      ),
                      const Spacer(),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _formatPrice(price),
                          maxLines: 1,
                          style: GoogleFonts.syne(
                            color: colors.primary,
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            height: 29 / 27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static double _parsePrice(Object? value) {
    if (value is num) return value.toDouble();

    final normalized = value?.toString().replaceAll(',', '.') ?? '';
    return double.tryParse(normalized) ?? 0;
  }

  static String _formatPrice(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({
    required this.colors,
    required this.selected,
    required this.onPressed,
  });

  final CategoryLayoutColors colors;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Icon(
            selected ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: colors.primary,
            size: 22,
          ),
        ),
      ),
    );
  }
}
