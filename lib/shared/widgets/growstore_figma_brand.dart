import 'package:flutter/material.dart';

class GrowStoreFigmaMark extends StatelessWidget {
  const GrowStoreFigmaMark({super.key});

  static const asset = 'assets/images/figma_auth_g_mark.png';

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      semanticLabel: 'GrowStore',
    );
  }
}

class GrowStoreFigmaWordmark extends StatelessWidget {
  const GrowStoreFigmaWordmark({super.key, required this.isDarkTheme});

  static const darkAsset = 'assets/images/figma_auth_wordmark_dark.png';
  static const lightAsset = 'assets/images/figma_auth_wordmark_light.png';

  final bool isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      isDarkTheme ? darkAsset : lightAsset,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      semanticLabel: 'GrowStore',
    );
  }
}
