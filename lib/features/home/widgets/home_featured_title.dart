import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';

class HomeFeaturedTitle extends StatelessWidget {
  const HomeFeaturedTitle({
    super.key,
    required this.colors,
    required this.onViewAll,
  });

  final HomeLayoutColors colors;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Produtos em Destaque',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.syne(
                  color: colors.title,
                  fontSize: 24,
                  height: 22 / 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              style: TextButton.styleFrom(
                foregroundColor: colors.primary,
                padding: EdgeInsets.zero,
                minimumSize: const Size(80, 40),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Ver todos>>',
                style: GoogleFonts.syne(
                  color: colors.primary,
                  fontSize: 12,
                  height: 22 / 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
