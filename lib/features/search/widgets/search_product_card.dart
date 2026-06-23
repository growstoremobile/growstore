import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/search/widgets/search_layout_colors.dart';

class SearchProductCard extends StatelessWidget {
  const SearchProductCard({
    super.key,
    required this.product,
    required this.colors,
    required this.onTap,
  });

  final Map<String, dynamic> product;
  final SearchLayoutColors colors;
  final VoidCallback onTap;

  String get _title => (product['title'] ?? '').toString();
  String get _category => (product['category'] ?? 'PRODUCT').toString();
  String get _image => (product['image'] ?? '').toString();
  double get _price => ((product['price'] ?? 0) as num).toDouble();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: colors.card,
          border: Border.all(color: colors.cardBorder),
          borderRadius: BorderRadius.circular(14),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.topCenter,
                        radius: .9,
                        colors: [
                          colors.primary.withValues(alpha: .22),
                          colors.imageBackground,
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: _image.isEmpty
                        ? Icon(
                            Icons.inventory_2_outlined,
                            color: colors.primary,
                            size: 42,
                          )
                        : Image.network(
                            _image,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.broken_image_outlined,
                              color: colors.primary,
                              size: 42,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _category.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.jetBrainsMono(
                      color: colors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      height: 14 / 10,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 19 / 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'R\$ ${_price.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: GoogleFonts.jetBrainsMono(
                      color: colors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 18 / 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
