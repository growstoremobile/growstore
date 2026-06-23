import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';

class HomeCategoryCarousel extends StatelessWidget {
  const HomeCategoryCarousel({
    super.key,
    required this.categories,
    required this.colors,
  });

  final List<String> categories;
  final HomeLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 11, 16, 11),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == 0;

          return _HomeCategoryChip(
            label: categories[index],
            selected: selected,
            colors: colors,
          );
        },
      ),
    );
  }
}

class _HomeCategoryChip extends StatelessWidget {
  const _HomeCategoryChip({
    required this.label,
    required this.selected,
    required this.colors,
  });

  final String label;
  final bool selected;
  final HomeLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 93),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? colors.categorySelectedBg : colors.categoryBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected
              ? colors.categorySelectedBorder
              : colors.categoryBorder,
        ),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.syne(
          color: selected ? colors.categorySelectedText : colors.categoryText,
          fontSize: 16,
          height: 20 / 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
