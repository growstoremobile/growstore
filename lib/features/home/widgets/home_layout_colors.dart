import 'package:flutter/material.dart';

class HomeLayoutColors {
  const HomeLayoutColors({
    required this.primary,
    required this.page,
    required this.statusBar,
    required this.searchBar,
    required this.searchField,
    required this.searchText,
    required this.avatarBorder,
    required this.avatarIcon,
    required this.divider,
    required this.categoryBg,
    required this.categoryText,
    required this.categoryBorder,
    required this.categorySelectedBg,
    required this.categorySelectedText,
    required this.categorySelectedBorder,
    required this.carouselBorder,
    required this.title,
    required this.productGrid,
    required this.productCard,
    required this.productBorder,
    required this.productName,
    required this.bottomBar,
  });

  final Color primary;
  final Color page;
  final Color statusBar;
  final Color searchBar;
  final Color searchField;
  final Color searchText;
  final Color avatarBorder;
  final Color avatarIcon;
  final Color divider;
  final Color categoryBg;
  final Color categoryText;
  final Color categoryBorder;
  final Color categorySelectedBg;
  final Color categorySelectedText;
  final Color categorySelectedBorder;
  final Color carouselBorder;
  final Color title;
  final Color productGrid;
  final Color productCard;
  final Color productBorder;
  final Color productName;
  final Color bottomBar;

  static HomeLayoutColors resolve(bool isDark) {
    const primary = Color(0xFF40A937);

    if (isDark) {
      return const HomeLayoutColors(
        primary: primary,
        page: Color(0xFF04090F),
        statusBar: Color(0xFF04090F),
        searchBar: Color(0x661B263B),
        searchField: Color(0xFF27323F),
        searchText: Color(0xFF7D848C),
        avatarBorder: Color(0xFF7D848C),
        avatarIcon: Color(0xFF7D848C),
        divider: primary,
        categoryBg: Color(0xFF0F1B2A),
        categoryText: Color(0xFFE2E3DF),
        categoryBorder: Colors.transparent,
        categorySelectedBg: Color(0x4D40A937),
        categorySelectedText: primary,
        categorySelectedBorder: Colors.transparent,
        carouselBorder: Color(0x1A40A937),
        title: Color(0xFFE2E3DF),
        productGrid: Color(0xFF04090F),
        productCard: Color(0x661B263B),
        productBorder: Color(0x4D40A937),
        productName: Color(0xFFE2E3DF),
        bottomBar: Color(0xFF0F1B2A),
      );
    }

    return const HomeLayoutColors(
      primary: primary,
      page: Color(0xFFF8F9FA),
      statusBar: primary,
      searchBar: primary,
      searchField: Colors.white,
      searchText: Color(0xFF7D848C),
      avatarBorder: Colors.white,
      avatarIcon: Colors.white,
      divider: Color(0xFFE7E8E9),
      categoryBg: Colors.transparent,
      categoryText: primary,
      categoryBorder: primary,
      categorySelectedBg: primary,
      categorySelectedText: Colors.white,
      categorySelectedBorder: Colors.white,
      carouselBorder: Color(0x1A40A937),
      title: Color(0xFF191C1D),
      productGrid: Colors.white,
      productCard: Color(0x1A40A937),
      productBorder: Color(0x4D40A937),
      productName: Color(0xFF191C1D),
      bottomBar: Color(0xFFE7E8E9),
    );
  }
}
