import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/categories/widgets/category_layout_colors.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({
    super.key,
    required this.title,
    required this.colors,
    required this.onProfile,
    this.onBack,
    this.controller,
    this.onSearchTap,
    this.onClear,
  });

  final String title;
  final CategoryLayoutColors colors;
  final VoidCallback onProfile;
  final VoidCallback? onBack;
  final TextEditingController? controller;
  final VoidCallback? onSearchTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Container(
      width: double.infinity,
      height: topInset + 113,
      decoration: BoxDecoration(
        color: colors.header,
        border: Border(bottom: BorderSide(color: colors.divider)),
      ),
      child: Column(
        children: [
          SizedBox(height: topInset),
          SizedBox(
            height: 44,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (onBack != null)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: onBack,
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        color: colors.icon,
                        size: 32,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 72),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      color: colors.title,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 29 / 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 68,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: _SearchField(
                      colors: colors,
                      controller: controller,
                      onTap: onSearchTap,
                      onClear: onClear,
                    ),
                  ),
                  const SizedBox(width: 16),
                  _ProfileButton(colors: colors, onTap: onProfile),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.colors,
    required this.controller,
    required this.onTap,
    required this.onClear,
  });

  final CategoryLayoutColors colors;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.inter(
      color: colors.categoryText,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 17 / 14,
    );

    return SizedBox(
      height: 36,
      child: TextField(
        controller: controller,
        readOnly: controller == null,
        onTap: onTap,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        cursorColor: colors.primary,
        style: textStyle,
        decoration: InputDecoration(
          hintText: 'Buscar produtos...',
          hintStyle: textStyle.copyWith(color: colors.searchText),
          prefixIcon: Icon(Icons.search_rounded, color: colors.searchText),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 34,
            minHeight: 36,
          ),
          suffixIcon: controller == null
              ? null
              : ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller!,
                  builder: (_, value, _) {
                    if (value.text.isEmpty) return const SizedBox.shrink();

                    return IconButton(
                      onPressed: onClear,
                      icon: Icon(
                        Icons.close_rounded,
                        color: colors.searchText,
                        size: 18,
                      ),
                    );
                  },
                ),
          filled: true,
          fillColor: colors.searchField,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({required this.colors, required this.onTap});

  final CategoryLayoutColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: Material(
        color: Colors.transparent,
        shape: CircleBorder(
          side: BorderSide(color: colors.avatarBorder, width: 1.4),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Icon(
            Icons.person_outline_rounded,
            color: colors.avatarBorder,
            size: 22,
          ),
        ),
      ),
    );
  }
}
