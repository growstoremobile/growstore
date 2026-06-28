import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/categories/models/category_summary.dart';
import 'package:growstore/features/categories/widgets/category_layout_colors.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
    required this.colors,
    required this.onTap,
  });

  final CategorySummary category;
  final CategoryLayoutColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.categoryCard,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: colors.categoryCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.categoryBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 7, 4, 8),
            child: Column(
              children: [
                SizedBox(
                  height: 31,
                  child: Center(
                    child: Text(
                      _categoryIcon(category.name),
                      style: const TextStyle(fontSize: 27, height: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  category.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    color: colors.categoryText,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 22 / 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _itemCountLabel(category.productCount),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: colors.categoryMeta,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 16 / 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _itemCountLabel(int count) {
    return count == 1 ? '1 item' : '$count itens';
  }

  static String _categoryIcon(String name) {
    final normalized = name.toLowerCase();

    if (normalized.contains('camis') || normalized.contains('vest')) {
      return '👕';
    }
    if (normalized.contains('caneca') || normalized.contains('cozinha')) {
      return '☕';
    }
    if (normalized.contains('mochila')) {
      return '🎒';
    }
    if (normalized.contains('garrafa')) {
      return '🥛';
    }
    if (normalized.contains('copo')) {
      return '🥤';
    }
    if (normalized.contains('caderno')) {
      return '📗';
    }
    if (normalized.contains('caneta')) {
      return '🖊️';
    }
    if (normalized.contains('adesivo')) {
      return '🏷️';
    }
    if (normalized.contains('mouse') || normalized.contains('inform')) {
      return '🖱️';
    }

    return '🛍️';
  }
}
