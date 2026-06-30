import 'package:flutter/material.dart';
import 'package:growstore/core/theme/growstore_theme.dart';

class ProductDetailImageWidget extends StatefulWidget {
  final List<String> pathImages;
  final String? selectedColor;

  const ProductDetailImageWidget({
    super.key,
    required this.pathImages,
    this.selectedColor,
  });

  @override
  State<ProductDetailImageWidget> createState() =>
      _ProductDetailImageWidgetState();
}

class _ProductDetailImageWidgetState extends State<ProductDetailImageWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final resolvedImages = _resolveImages();

    if (resolvedImages.isEmpty) {
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
              height: 345,
              child: PageView.builder(
                itemCount: resolvedImages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final imagePath = resolvedImages[index];

                  if (imagePath.startsWith('assets/')) {
                    return Image.asset(
                      imagePath,
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder();
                      },
                    );
                  }

                  return Image.network(
                    imagePath,
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                          color: GrowColors.primary,
                        ),
                      );
                    },
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

        if (resolvedImages.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              resolvedImages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? GrowColors.primary
                      : GrowColors.darkTextSecondary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
      ],
    );
  }

  List<String> _resolveImages() {
    final color = widget.selectedColor?.toLowerCase();
    final gallery = widget.pathImages;

    if (gallery.isEmpty) return gallery;

    if (color == '#ffffff' || color == '#fff' || color == 'branco') {
      final candidates = gallery
          .where(
            (p) =>
                p.toLowerCase().contains('branc') ||
                p.toLowerCase().contains('white'),
          )
          .toList();

      if (candidates.isNotEmpty) return candidates;
    }

    if (color == '#0a0a0a' || color == '#000' || color == 'preto') {
      final candidates = gallery
          .where(
            (p) =>
                p.toLowerCase().contains('preto') ||
                p.toLowerCase().contains('black'),
          )
          .toList();

      if (candidates.isNotEmpty) return candidates;
    }

    return gallery;
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
