import 'package:flutter/material.dart';

import '../../theme/colors_theme.dart';

/// Widget de loading com efeito shimmer.
///
/// Use [GrowSkeletonBox] para blocos genéricos e
/// [GrowProductCardSkeleton] para simular o card de produto.
///
/// Usage:
/// ```dart
/// // Grid de produtos carregando
/// GridView.builder(
///   itemCount: 6,
///   itemBuilder: (_, __) => const GrowProductCardSkeleton(),
/// )
///
/// // Bloco genérico
/// GrowSkeletonBox(width: 120, height: 16)
/// ```

//  Base brilhante

class _GrowShimmer extends StatefulWidget {
  final Widget child;

  const _GrowShimmer({required this.child});

  @override
  State<_GrowShimmer> createState() => _GrowShimmerState();
}

class _GrowShimmerState extends State<_GrowShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _animation = Tween<double>(
      begin: -1.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark
        ? GrowColors.darkSurfaceElevated
        : GrowColors.lightSurfaceElevated;
    final highlightColor = isDark
        ? const Color(0xFF2A2A2A)
        : const Color(0xFFE0E0E0);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [baseColor, highlightColor, baseColor],
            stops: [
              (_animation.value - 0.3).clamp(0.0, 1.0),
              (_animation.value).clamp(0.0, 1.0),
              (_animation.value + 0.3).clamp(0.0, 1.0),
            ],
          ).createShader(bounds),
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

//  Bloco genérico

class GrowSkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const GrowSkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark
        ? GrowColors.darkSurfaceElevated
        : GrowColors.lightSurfaceElevated;

    return _GrowShimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

//  Card de produto skeleton

class GrowProductCardSkeleton extends StatelessWidget {
  const GrowProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? GrowColors.darkSurface : GrowColors.lightSurface;
    final borderColor = isDark ? GrowColors.darkBorder : GrowColors.lightBorder;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
            child: GrowSkeletonBox(
              width: double.infinity,
              height: 140,
              borderRadius: 0,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome do produto — linha 1
                GrowSkeletonBox(width: double.infinity, height: 14),
                SizedBox(height: 6),
                // Nome do produto — linha 2
                GrowSkeletonBox(width: 100, height: 14),
                SizedBox(height: 12),
                // Preço
                GrowSkeletonBox(width: 80, height: 20),
                SizedBox(height: 12),
                // Botão Adicionar
                GrowSkeletonBox(
                  width: double.infinity,
                  height: 40,
                  borderRadius: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//  Item de carrinho skeleton

class GrowCartItemSkeleton extends StatelessWidget {
  const GrowCartItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? GrowColors.darkSurface : GrowColors.lightSurface;
    final borderColor = isDark ? GrowColors.darkBorder : GrowColors.lightBorder;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: const Row(
        children: [
          // Thumbnail
          GrowSkeletonBox(width: 64, height: 64, borderRadius: 8),
          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GrowSkeletonBox(width: double.infinity, height: 14),
                SizedBox(height: 6),
                GrowSkeletonBox(width: 120, height: 12),
                SizedBox(height: 12),
                Row(
                  children: [
                    GrowSkeletonBox(width: 80, height: 32, borderRadius: 6),
                    Spacer(),
                    GrowSkeletonBox(width: 60, height: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
