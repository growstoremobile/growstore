import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCategoryCard extends StatelessWidget {
  const HomeCategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.asset,
    required this.alignment,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String asset;
  final Alignment alignment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 466,
        padding: const EdgeInsets.all(1),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFF111412).withValues(alpha: .60),
          border: Border.all(color: Colors.white.withValues(alpha: .10)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(asset, alignment: alignment, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xE604090F),
                    Color(0x0004090F),
                    Color(0x0004090F),
                  ],
                  stops: [0, .5, 1],
                ),
              ),
            ),
            Positioned(
              left: 32,
              right: 32,
              bottom: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: GoogleFonts.jetBrainsMono(
                      color: const Color(0xFF39FF14),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 16 / 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: GoogleFonts.syne(
                      color: const Color(0xFFE2E3DF),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 32 / 24,
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
