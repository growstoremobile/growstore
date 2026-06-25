import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({super.key, required this.onShop});

  final VoidCallback onShop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 760,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/figma_home_hero.png',
            alignment: const Alignment(.30, 0),
            fit: BoxFit.cover,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF04090F),
                  Color(0x6604090F),
                  Color(0x0004090F),
                ],
                stops: [0, .5, 1],
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 20,
            right: 20,
            child: _HeroContent(onShop: onShop),
          ),
        ],
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({required this.onShop});

  final VoidCallback onShop;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 32,
              child: Divider(color: Color(0xFF39FF14), thickness: 1),
            ),
            const SizedBox(width: 8),
            Text(
              'WELCOME TO',
              style: GoogleFonts.jetBrainsMono(
                color: const Color(0xFF39FF14),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 16 / 12,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'GEAR THAT',
          style: GoogleFonts.syne(
            color: const Color(0xFFE2E3DF),
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 34 / 28,
            letterSpacing: -.28,
          ),
        ),
        Text(
          'BUILDS MORE',
          style: GoogleFonts.syne(
            color: const Color(0xFF39FF14),
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 34 / 28,
            letterSpacing: -.28,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Premium merchandise for developers\n'
          'who ship, scale, and innovate the future.',
          style: GoogleFonts.inter(
            color: const Color(0xFFBACCB0),
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 28 / 18,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 177.5,
          height: 52,
          child: FilledButton(
            onPressed: onShop,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF39FF14),
              foregroundColor: const Color(0xFF04090F),
              padding: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'SHOP NOW',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF04090F),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 20 / 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 19),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        const _HeroBenefit(
          icon: Icons.verified_outlined,
          label: 'PREMIUM QUALITY',
        ),
        const SizedBox(height: 32),
        const _HeroBenefit(
          icon: Icons.code_rounded,
          label: 'DEVELOPER FOCUSED',
        ),
      ],
    );
  }
}

class _HeroBenefit extends StatelessWidget {
  const _HeroBenefit({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF39FF14), size: 20),
        const SizedBox(width: 9),
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            color: const Color(0xFFE2E3DF),
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 16 / 12,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
