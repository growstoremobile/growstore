import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchProductCard extends StatelessWidget {
  const SearchProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  final Map<String, dynamic> product;
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
          color: const Color(0xFF111412).withValues(alpha: .72),
          border: Border.all(color: Colors.white.withValues(alpha: .10)),
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
                          const Color(0xFF39FF14).withValues(alpha: .22),
                          const Color(0xFF04090F),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: _image.isEmpty
                        ? const Icon(
                            Icons.inventory_2_outlined,
                            color: Color(0xFF39FF14),
                            size: 42,
                          )
                        : Image.network(
                            _image,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => const Icon(
                              Icons.broken_image_outlined,
                              color: Color(0xFF39FF14),
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
                      color: const Color(0xFFBACCB0),
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
                      color: const Color(0xFFE2E3DF),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 19 / 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'R\$ ${_price.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: GoogleFonts.jetBrainsMono(
                      color: const Color(0xFF39FF14),
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
