import 'package:flutter/material.dart';

class CategoryLayoutColors {
  const CategoryLayoutColors({
    required this.isDark,
    required this.primary,
    required this.header,
    required this.page,
    required this.divider,
    required this.searchField,
    required this.searchText,
    required this.title,
    required this.icon,
    required this.avatarBorder,
    required this.categoryCard,
    required this.categoryBorder,
    required this.categoryText,
    required this.categoryMeta,
    required this.productCard,
    required this.productBorder,
    required this.productImage,
    required this.productInfo,
    required this.bottomBar,
  });

  final bool isDark;
  final Color primary;
  final Color header;
  final Color page;
  final Color divider;
  final Color searchField;
  final Color searchText;
  final Color title;
  final Color icon;
  final Color avatarBorder;
  final Color categoryCard;
  final Color categoryBorder;
  final Color categoryText;
  final Color categoryMeta;
  final Color productCard;
  final Color productBorder;
  final Color productImage;
  final Color productInfo;
  final Color bottomBar;

  static CategoryLayoutColors resolve(bool isDark) {
    const primary = Color(0xFF40A937);

    if (isDark) {
      return const CategoryLayoutColors(
        isDark: true,
        primary: primary,
        header: Color(0xFF0D1421),
        page: Color(0xFF04090F),
        divider: Color(0xFF0C3A19),
        searchField: Color(0xFF27323F),
        searchText: Color(0xFF9AA2AB),
        title: Color(0xFFE2E3DF),
        icon: Color(0xFFE2E3DF),
        avatarBorder: Color(0xFF7D848C),
        categoryCard: Color(0xFF04090F),
        categoryBorder: Color(0xFF0C3A19),
        categoryText: Color(0xFFE2E3DF),
        categoryMeta: Color(0xFF7D848C),
        productCard: Color(0xFF04090F),
        productBorder: Color(0xFF0C3A19),
        productImage: Colors.white,
        productInfo: Color(0xFF04090F),
        bottomBar: Color(0xFF0F1B2A),
      );
    }

    return const CategoryLayoutColors(
      isDark: false,
      primary: primary,
      header: primary,
      page: Color(0xFFF8F9FA),
      divider: Color(0xFFB8DDB9),
      searchField: Colors.white,
      searchText: Color(0xFF7D848C),
      title: Colors.black,
      icon: Colors.black,
      avatarBorder: Colors.white,
      categoryCard: Color(0xFFE8F4EA),
      categoryBorder: Color(0xFFA8DDA8),
      categoryText: Color(0xFF191C1D),
      categoryMeta: primary,
      productCard: Color(0xFFE8F4EA),
      productBorder: Color(0xFFA8DDA8),
      productImage: Colors.white,
      productInfo: Color(0xFFE8F4EA),
      bottomBar: Color(0xFFE7E8E9),
    );
  }
}
