import 'package:flutter/material.dart';

class FigmaPhoneCanvas extends StatelessWidget {
  const FigmaPhoneCanvas({
    super.key,
    required this.backgroundColor,
    required this.children,
  });

  static const designWidth = 402.0;
  static const designHeight = 874.0;

  final Color backgroundColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: designWidth,
            height: designHeight,
            child: Stack(clipBehavior: Clip.none, children: children),
          ),
        ),
      ),
    );
  }
}
