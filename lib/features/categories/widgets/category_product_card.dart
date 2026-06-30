import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/categories/widgets/category_layout_colors.dart';
import 'package:growstore/shared/utils/price_utils.dart';
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

  String get _title => _productTitle(product);
  String get _image => _productImage(product);

  @override
  Widget build(BuildContext context) {
    final price = _productPrice(product);

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
                          formatGrowCurrency(price),
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
}

class CategoryProductListTile extends StatelessWidget {
  const CategoryProductListTile({
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

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.productCard,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          height: 118,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colors.productCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.productBorder),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: SizedBox.square(
                  dimension: 96,
                  child: GrowCachedProductImage(
                    imageUrl: _productImage(product),
                    backgroundColor: colors.productImage,
                    iconColor: colors.primary,
                    fit: BoxFit.contain,
                    padding: const EdgeInsets.all(8),
                    cacheWidth: 260,
                    cacheHeight: 260,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _productTitle(product),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: colors.categoryText,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 19 / 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _productCategory(product),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: colors.categoryMeta,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 15 / 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      formatGrowCurrency(_productPrice(product)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.syne(
                        color: colors.primary,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        height: 27 / 23,
                      ),
                    ),
                  ],
                ),
              ),
              if (onFavorite != null) ...[
                const SizedBox(width: 8),
                _FavoriteButton(
                  colors: colors,
                  selected: isFavorite,
                  onPressed: onFavorite,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

String _productTitle(Map<String, dynamic> product) {
  return (product['title'] ?? product['title_product'] ?? 'Produto').toString();
}

String _productImage(Map<String, dynamic> product) {
  final detail = _firstProductDetail(product['product_details']);

  return (product['image'] ??
          product['imageUrl'] ??
          product['path_image'] ??
          detail?['main_image'] ??
          '')
      .toString();
}

String _productCategory(Map<String, dynamic> product) {
  return (product['category'] ?? product['categoria'] ?? 'Produto').toString();
}

double _productPrice(Map<String, dynamic> product) {
  final detail = _firstProductDetail(product['product_details']);

  return parseGrowPrice(
    product['price'] ?? product['price_product'] ?? detail?['price'],
  );
}

Map<String, dynamic>? _firstProductDetail(Object? details) {
  if (details is Map) {
    return Map<String, dynamic>.from(details);
  }

  if (details is List && details.isNotEmpty && details.first is Map) {
    return Map<String, dynamic>.from(details.first as Map);
  }

  return null;
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
