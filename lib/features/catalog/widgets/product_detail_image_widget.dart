import 'package:flutter/material.dart';
import 'package:growstore/core/theme/growstore_theme.dart';

class ProductDetailImageWidget extends StatefulWidget {
  final List<String> pathImages;

  const ProductDetailImageWidget({super.key, required this.pathImages});

  @override
  State<ProductDetailImageWidget> createState() =>
      _ProductDetailImageWidgetState();
}

class _ProductDetailImageWidgetState extends State<ProductDetailImageWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.pathImages.isEmpty) {
      return _buildPlaceholder();
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: GrowColors.darkSurface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 320,
              child: PageView.builder(
                itemCount: widget.pathImages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    widget.pathImages[index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholder();
                    },
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        if (widget.pathImages.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.pathImages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? const Color(0xFF3DDC6B)
                      : GrowColors.darkTextSecondary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 320,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: GrowColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: GrowColors.darkTextSecondary,
          size: 48,
        ),
      ),
    );
  }
}
