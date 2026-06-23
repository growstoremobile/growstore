import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.onMenu, required this.onSearch});

  final VoidCallback onMenu;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF111412).withValues(alpha: .60),
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: .10)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onMenu,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 34, height: 34),
            splashRadius: 20,
            icon: const Icon(
              Icons.menu_rounded,
              color: Color(0xFF39FF14),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'GROW STORE',
            style: GoogleFonts.syne(
              color: const Color(0xFFE2E3DF),
              fontSize: 24,
              height: 32 / 24,
              letterSpacing: -1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onSearch,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 34, height: 34),
            splashRadius: 20,
            icon: const Icon(
              Icons.search_rounded,
              color: Color(0xFF39FF14),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
