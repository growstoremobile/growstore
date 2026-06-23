import 'package:flutter/material.dart';
import 'package:growstore/features/home/models/home_carousel_item_model.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';

class HomePromoCarousel extends StatelessWidget {
  const HomePromoCarousel({
    super.key,
    required this.items,
    required this.colors,
    required this.isDark,
  });

  final List<HomeCarouselItemModel> items;
  final HomeLayoutColors colors;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isDark ? 160 : 192,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(16, isDark ? 0 : 16, 16, isDark ? 0 : 16),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = items[index];

          return Container(
            width: item.width,
            height: 160,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.carouselBorder),
            ),
            child: Image.asset(item.asset, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
