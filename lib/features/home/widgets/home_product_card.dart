import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeProductCard extends StatelessWidget {
  const HomeProductCard({
    super.key,
    required this.category,
    required this.title,
    required this.price,
    required this.asset,
    required this.onTap,
  });

  final String category;
  final String title;
  final String price;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 222.66,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFF111412).withValues(alpha: .60),
              border: Border.all(color: Colors.white.withValues(alpha: .10)),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(asset, fit: BoxFit.cover),
                Positioned(
                  right: 17,
                  bottom: 9,
                  child: Container(
                    width: 38.7,
                    height: 39,
                    decoration: BoxDecoration(
                      color: const Color(0xFF39FF14).withValues(alpha: .92),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xFF04090F),
                      size: 21,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.jetBrainsMono(
              color: const Color(0xFFBACCB0),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 16 / 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: const Color(0xFFE2E3DF),
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 24 / 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: GoogleFonts.jetBrainsMono(
              color: const Color(0xFF39FF14),
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 24 / 16,
            ),
          ),
        ],
      ),
    );
  }
}
