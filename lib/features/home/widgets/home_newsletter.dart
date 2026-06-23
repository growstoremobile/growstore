import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeNewsletter extends StatelessWidget {
  const HomeNewsletter({super.key, required this.onSubscribe});

  final VoidCallback onSubscribe;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 472,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF111412).withValues(alpha: .60),
        border: Border.all(color: Colors.white.withValues(alpha: .10)),
      ),
      child: Stack(
        children: [
          Positioned(top: -63, right: -95, child: _GlowCircle()),
          Positioned(left: -95, bottom: -95, child: _GlowCircle()),
          Center(
            child: SizedBox(
              width: 252,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'JOIN THE GROW\nCREW',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      color: const Color(0xFFE2E3DF),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 32 / 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Get exclusive access to drop\n'
                    'notifications, community-only\n'
                    'designs, and early bird\n'
                    'discounts.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFBACCB0),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 24 / 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: const Color(0xFF04090F),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: .10),
                      ),
                    ),
                    child: Text(
                      'ENTER YOUR EMAIL',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: onSubscribe,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF39FF14),
                        foregroundColor: const Color(0xFF04090F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      child: Text(
                        'SUBSCRIBE',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF04090F),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 20 / 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      height: 256,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF39FF14).withValues(alpha: .12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4039FF14),
            blurRadius: 100,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}
