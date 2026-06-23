import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';
import 'package:growstore/shared/widgets/theme_toggle_button.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    required this.colors,
    required this.isDark,
    required this.onSearch,
    required this.onProfile,
    required this.onThemeToggle,
  });

  final HomeLayoutColors colors;
  final bool isDark;
  final VoidCallback onSearch;
  final VoidCallback onProfile;
  final VoidCallback onThemeToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isDark ? 68 : 67,
      color: colors.searchBar,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: colors.searchField,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: onSearch,
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 36,
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Icon(
                        Icons.search_rounded,
                        size: 22,
                        color: colors.searchText,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Buscar produtos...',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.syne(
                            color: colors.searchText,
                            fontSize: 17,
                            height: 22 / 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          _HomeHeaderIconButton(
            tooltip: 'Perfil',
            icon: Icons.person_outline_rounded,
            colors: colors,
            onTap: onProfile,
          ),
          const SizedBox(width: 8),
          ThemeToggleButton(
            isDark: isDark,
            onPressed: onThemeToggle,
            borderColor: colors.avatarBorder,
            iconColor: colors.avatarIcon,
          ),
        ],
      ),
    );
  }
}

class _HomeHeaderIconButton extends StatelessWidget {
  const _HomeHeaderIconButton({
    this.tooltip,
    required this.icon,
    required this.colors,
    required this.onTap,
  });

  final String? tooltip;
  final IconData icon;
  final HomeLayoutColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final button = InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors.avatarBorder),
        ),
        child: Icon(icon, color: colors.avatarIcon, size: 20),
      ),
    );

    if (tooltip == null) return button;

    return Tooltip(message: tooltip!, child: button);
  }
}
