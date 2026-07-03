import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';

class CategorySearchBar extends StatelessWidget {
  const CategorySearchBar({
    super.key,
    required this.colors,
    required this.isDark,
    required this.onSearchChanged,
    required this.onProfile,
    this.showProfile = true,
  });

  final HomeLayoutColors colors;
  final bool isDark;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onProfile;
  final bool showProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isDark ? 68 : 67,
      color: colors.searchBar,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 36,
              child: TextField(
                onChanged: onSearchChanged,
                style: GoogleFonts.syne(
                  color: colors.searchText,
                  fontSize: 17,
                  height: 22 / 17,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.searchField,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 22,
                    color: colors.searchText,
                  ),
                  hintText: 'Buscar produtos...',
                  hintStyle: GoogleFonts.syne(
                    color: colors.searchText,
                    fontSize: 17,
                    height: 22 / 17,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: colors.primary),
                  ),
                ),
              ),
            ),
          ),
          if (showProfile) ...[
            const SizedBox(width: 16),
            Tooltip(
              message: 'Perfil',
              child: InkWell(
                onTap: onProfile,
                customBorder: const CircleBorder(),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.avatarBorder),
                  ),
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: colors.avatarIcon,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
