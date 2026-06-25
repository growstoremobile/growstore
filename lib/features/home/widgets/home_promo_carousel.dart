import 'dart:async';

import 'package:flutter/material.dart';
import 'package:growstore/features/home/models/home_carousel_item_model.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';

class HomePromoCarousel extends StatefulWidget {
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
  State<HomePromoCarousel> createState() => _HomePromoCarouselState();
}

class _HomePromoCarouselState extends State<HomePromoCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    if (widget.items.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 4), (_) {
        if (!mounted || !_controller.hasClients) return;

        final nextPage = (_currentPage + 1) % widget.items.length;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 360),
          curve: Curves.easeOutCubic,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: widget.isDark ? 180 : 212,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          widget.isDark ? 8 : 16,
          16,
          widget.isDark ? 12 : 16,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.items.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                final item = widget.items[index];

                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: widget.colors.carouselBorder),
                  ),
                  child: Image.asset(item.asset, fit: BoxFit.cover),
                );
              },
            ),
            Positioned(
              bottom: 10,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.items.length, (index) {
                  final selected = index == _currentPage;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: selected ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: selected
                          ? widget.colors.primary
                          : Colors.white.withValues(alpha: .72),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
