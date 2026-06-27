import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/auth/repositories/auth_repository.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/home/widgets/home_bottom_navigation.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final _authStore = GetIt.I.get<AuthStore>();
  final CartStore? _cartStore = GetIt.I.isRegistered<CartStore>()
      ? GetIt.I<CartStore>()
      : null;

  Future<void> _handleLogout(BuildContext context) async {
    await AuthRepository().logout();
    _authStore.logout();

    if (GetIt.I.isRegistered<CartStore>()) {
      GetIt.I<CartStore>().clearCart();
    }

    if (!context.mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  void _comingSoon(BuildContext context, String destination) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$destination em breve.')));
  }

  void _handleMenuTap(BuildContext context, String label) {
    switch (label) {
      case 'Início':
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/home', (route) => false);
        break;
      case 'Buscar':
        Navigator.of(context).pushNamed('/search');
        break;
      case 'Categorias':
        Navigator.of(context).pushNamed('/catalog');
        break;
      case 'Favoritos':
        Navigator.of(context).pushNamed('/favorites');
        break;
      case 'Carrinho':
        Navigator.of(context).pushNamed('/cart');
        break;
      case 'Sair':
        _handleLogout(context);
        break;
      default:
        _comingSoon(context, label);
        break;
    }
  }

  void _handleBottomNavigation(BuildContext context, String label) {
    switch (label) {
      case 'Inicio':
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/home', (route) => false);
        break;
      case 'Categorias':
        Navigator.of(context).pushNamed('/catalog');
        break;
      case 'Carrinho':
        Navigator.of(context).pushNamed('/cart');
        break;
      case 'Favoritos':
        Navigator.of(context).pushNamed('/favorites');
        break;
      case 'Pedidos':
        _comingSoon(context, label);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _ProfileLayoutColors.resolve(
      Theme.of(context).brightness == Brightness.dark,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: colors.statusBar,
        statusBarIconBrightness: colors.isDark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: colors.isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: colors.bottomBar,
        systemNavigationBarIconBrightness: colors.isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: colors.page,
        body: Observer(
          builder: (_) {
            final name = _authStore.user?.name.trim();
            final firstName = (name == null || name.isEmpty)
                ? 'Visitante'
                : name.split(RegExp(r'\s+')).first;

            return Column(
              children: [
                _ProfileHeader(colors: colors, userName: firstName),
                Expanded(
                  child: _ProfileMenu(
                    colors: colors,
                    onTap: (label) => _handleMenuTap(context, label),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Observer(
          builder: (_) => HomeBottomNavigation(
            selectedLabel: '',
            showCartBadge: false,
            cartItemCount: _cartStore?.totalItems ?? 0,
            onTap: (label) => _handleBottomNavigation(context, label),
          ),
        ),
      ),
    );
  }
}

class _ProfileLayoutColors {
  const _ProfileLayoutColors({
    required this.isDark,
    required this.statusBar,
    required this.header,
    required this.page,
    required this.bottomBar,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.primary,
    required this.avatarBorder,
    required this.avatarIcon,
    required this.brandPill,
    required this.brandText,
    required this.brandArrow,
    required this.menuActive,
  });

  factory _ProfileLayoutColors.resolve(bool isDark) {
    if (isDark) {
      return const _ProfileLayoutColors(
        isDark: true,
        statusBar: Color(0xFF0D1421),
        header: Color(0xFF0D1421),
        page: Color(0xFF04090F),
        bottomBar: Color(0xFF0F1B2A),
        divider: Color(0xFF0C3A19),
        textPrimary: Color(0xFFE2E3DF),
        textSecondary: Color(0xFFE2E3DF),
        primary: Color(0xFF40A937),
        avatarBorder: Color(0xFF40A937),
        avatarIcon: Color(0xFF919597),
        brandPill: Color(0xFF27323F),
        brandText: Color(0xFFE2E3DF),
        brandArrow: Color(0xFFE2E3DF),
        menuActive: Color(0xFF40A937),
      );
    }

    return const _ProfileLayoutColors(
      isDark: false,
      statusBar: Color(0xFF40A937),
      header: Color(0xFF40A937),
      page: Color(0xFFF8F9FA),
      bottomBar: Color(0xFFE7E8E9),
      divider: Color(0xFFB8DDB9),
      textPrimary: Color(0xFF191C1D),
      textSecondary: Color(0xFF191C1D),
      primary: Color(0xFF40A937),
      avatarBorder: Colors.white,
      avatarIcon: Color(0xFFA9DBA8),
      brandPill: Colors.white,
      brandText: Color(0xFF191C1D),
      brandArrow: Color(0xFF191C1D),
      menuActive: Color(0xFF191C1D),
    );
  }

  final bool isDark;
  final Color statusBar;
  final Color header;
  final Color page;
  final Color bottomBar;
  final Color divider;
  final Color textPrimary;
  final Color textSecondary;
  final Color primary;
  final Color avatarBorder;
  final Color avatarIcon;
  final Color brandPill;
  final Color brandText;
  final Color brandArrow;
  final Color menuActive;
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.colors, required this.userName});

  final _ProfileLayoutColors colors;
  final String userName;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final headerHeight = topInset + 188;

    return Container(
      height: headerHeight,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(21, topInset + 31, 20, 20),
      decoration: BoxDecoration(
        color: colors.header,
        border: Border(bottom: BorderSide(color: colors.divider)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 69,
                height: 69,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.avatarBorder, width: 4),
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  color: colors.avatarIcon,
                  size: 49,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Olá $userName',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.syne(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 22 / 18,
                    color: colors.textPrimary,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 31),
          _GrowStorePill(colors: colors),
        ],
      ),
    );
  }
}

class _GrowStorePill extends StatelessWidget {
  const _GrowStorePill({required this.colors});

  final _ProfileLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.brandPill,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/home', (route) => false),
        child: SizedBox(
          height: 36,
          child: Row(
            children: [
              const SizedBox(width: 12),
              Container(
                width: 19,
                height: 19,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'G',
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'GrowStore',
                  style: GoogleFonts.inter(
                    color: colors.brandText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 17 / 14,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: colors.brandArrow, size: 29),
              const SizedBox(width: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu({required this.colors, required this.onTap});

  final _ProfileLayoutColors colors;
  final ValueChanged<String> onTap;

  static const _mainItems = [
    (Icons.home_filled, 'Início'),
    (Icons.search_rounded, 'Buscar'),
    (Icons.grid_view_rounded, 'Categorias'),
    (Icons.favorite_rounded, 'Favoritos'),
    (Icons.shopping_basket_rounded, 'Minhas Compras'),
    (Icons.shopping_cart_rounded, 'Carrinho'),
  ];

  static const _secondaryItems = [
    (Icons.build_rounded, 'Configurações'),
    (Icons.logout_rounded, 'Sair'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.page,
      padding: const EdgeInsets.fromLTRB(29, 30, 22, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final item in _mainItems)
            _ProfileMenuItem(
              icon: item.$1,
              label: item.$2,
              colors: colors,
              active: item.$2 == 'Início',
              onTap: () => onTap(item.$2),
            ),
          const Spacer(),
          for (final item in _secondaryItems)
            _ProfileMenuItem(
              icon: item.$1,
              label: item.$2,
              colors: colors,
              active: false,
              onTap: () => onTap(item.$2),
            ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.colors,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final _ProfileLayoutColors colors;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? colors.menuActive : colors.textSecondary;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            SizedBox(width: 25, child: Icon(icon, size: 25, color: color)),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.syne(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 19 / 16,
                  color: color,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
