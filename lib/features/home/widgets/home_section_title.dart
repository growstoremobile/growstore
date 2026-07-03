import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle(this.label, {super.key, this.showIndicator = true});

  final String label;
  final bool showIndicator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.syne(
            color: const Color(0xFFE2E3DF),
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 32 / 24,
          ),
        ),
        if (showIndicator) ...[
          const SizedBox(height: 8),
          Container(width: 48, height: 4, color: const Color(0xFF39FF14)),
        ],
      ],
    );
  }
}
