import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMenuDrawer extends StatelessWidget {
  const HomeMenuDrawer({super.key, required this.onSelected});

  final ValueChanged<String> onSelected;

  static const _green = Color(0xFF39FF14);
  static const _background = Color(0xFF04090F);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 320,
      backgroundColor: _background,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.white.withValues(alpha: .10)),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              const Positioned(top: -90, right: -120, child: _Glow()),
              const Positioned(
                bottom: 80,
                left: -150,
                child: _Glow(opacity: .10),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _DrawerBrand(),
                    const SizedBox(height: 28),
                    Container(width: 48, height: 4, color: _green),
                    const SizedBox(height: 28),
                    _DrawerItem(
                      icon: Icons.home_filled,
                      label: 'Home',
                      subtitle: 'Voltar para o início',
                      selected: true,
                      onTap: () => onSelected('home'),
                    ),
                    _DrawerItem(
                      icon: Icons.storefront_outlined,
                      label: 'Loja',
                      subtitle: 'Produtos e coleções',
                      onTap: () => onSelected('shop'),
                    ),
                    _DrawerItem(
                      icon: Icons.shopping_cart_outlined,
                      label: 'Carrinho',
                      subtitle: 'Ver itens adicionados',
                      onTap: () => onSelected('cart'),
                    ),
                    _DrawerItem(
                      icon: Icons.favorite_border_rounded,
                      label: 'Favoritos',
                      subtitle: 'Produtos salvos',
                      onTap: () => onSelected('favorites'),
                    ),
                    _DrawerItem(
                      icon: Icons.person_outline_rounded,
                      label: 'Perfil',
                      subtitle: 'Conta e preferências',
                      onTap: () => onSelected('profile'),
                    ),
                    const Spacer(),
                    _MenuCta(onTap: () => onSelected('shop')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerBrand extends StatelessWidget {
  const _DrawerBrand();

  static const _green = Color(0xFF39FF14);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _green.withValues(alpha: .10),
            border: Border.all(color: _green),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Color(0x3339FF14), blurRadius: 18),
            ],
          ),
          child: Text(
            'G',
            style: GoogleFonts.syne(
              color: _green,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GROW STORE',
                style: GoogleFonts.syne(
                  color: const Color(0xFFE2E3DF),
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 28 / 22,
                  letterSpacing: -1,
                ),
              ),
              Text(
                'Developer merch',
                style: GoogleFonts.jetBrainsMono(
                  color: const Color(0xFFBACCB0),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  height: 16 / 11,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded, color: _green),
        ),
      ],
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  final bool selected;

  static const _green = Color(0xFF39FF14);
  static const _text = Color(0xFFE2E3DF);
  static const _muted = Color(0xFFBACCB0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected
                ? _green.withValues(alpha: .12)
                : Colors.white.withValues(alpha: .04),
            border: Border.all(
              color: selected ? _green : Colors.white.withValues(alpha: .08),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: selected ? _green : _muted, size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.syne(
                        color: selected ? _green : _text,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        height: 24 / 17,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        color: _muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 18 / 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: selected ? _green : _muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCta extends StatelessWidget {
  const _MenuCta({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF111412).withValues(alpha: .85),
        border: Border.all(
          color: const Color(0xFF39FF14).withValues(alpha: .35),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NEW DROP',
            style: GoogleFonts.jetBrainsMono(
              color: const Color(0xFF39FF14),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 16 / 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Gear feito para quem constrói o futuro.',
            style: GoogleFonts.inter(
              color: const Color(0xFFE2E3DF),
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 22 / 15,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: FilledButton(
              onPressed: onTap,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF39FF14),
                foregroundColor: const Color(0xFF04090F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'SHOP NOW',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 20 / 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({this.opacity = .16});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF39FF14).withValues(alpha: opacity),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3339FF14),
            blurRadius: 100,
            spreadRadius: 24,
          ),
        ],
      ),
    );
  }
}
