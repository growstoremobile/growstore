import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GrowCachedProductImage extends StatelessWidget {
  const GrowCachedProductImage({
    super.key,
    required this.imageUrl,
    required this.backgroundColor,
    required this.iconColor,
    this.fit = BoxFit.contain,
    this.padding = EdgeInsets.zero,
    this.cacheWidth = 420,
    this.cacheHeight = 420,
  });

  final String? imageUrl;
  final Color backgroundColor;
  final Color iconColor;
  final BoxFit fit;
  final EdgeInsetsGeometry padding;
  final int cacheWidth;
  final int cacheHeight;

  @override
  Widget build(BuildContext context) {
    final image = imageUrl?.trim() ?? '';

    return ColoredBox(
      color: backgroundColor,
      child: Padding(
        padding: padding,
        child: image.isEmpty
            ? _ImagePlaceholder(iconColor: iconColor)
            : _buildImage(image),
      ),
    );
  }

  Widget _buildImage(String image) {
    if (image.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: image,
        fit: fit,
        fadeInDuration: const Duration(milliseconds: 120),
        fadeOutDuration: const Duration(milliseconds: 80),
        memCacheWidth: cacheWidth,
        memCacheHeight: cacheHeight,
        maxWidthDiskCache: cacheWidth,
        maxHeightDiskCache: cacheHeight,
        placeholder: (_, _) => _ImagePlaceholder(iconColor: iconColor),
        errorWidget: (_, _, _) => _ImagePlaceholder(
          iconColor: iconColor,
          icon: Icons.broken_image_outlined,
        ),
      );
    }

    return Image.asset(
      image,
      fit: fit,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      errorBuilder: (_, _, _) => _ImagePlaceholder(
        iconColor: iconColor,
        icon: Icons.broken_image_outlined,
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({
    required this.iconColor,
    this.icon = Icons.inventory_2_outlined,
  });

  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(child: Icon(icon, color: iconColor, size: 42));
  }
}
