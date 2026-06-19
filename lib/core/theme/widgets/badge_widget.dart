import 'package:flutter/material.dart';

import '../colors_theme.dart';

enum GrowBadgeType { novo, maisVendido, discount }

/// Sobreposição de etiqueta para cartões de produtos.

/// /// Uso:
/// ```dart
/// GrowBadge(type: GrowBadgeType.novo)
/// GrowBadge(type: GrowBadgeType.maisVendido)
/// GrowBadge(type: GrowBadgeType.discount, customLabel: '-25%')
/// ```
class GrowBadge extends StatelessWidget {
  final GrowBadgeType type;

  /// Usado somente quando [type] for [GrowBadgeType.discount].
  final String? customLabel;

  const GrowBadge({super.key, required this.type, this.customLabel});

  @override
  Widget build(BuildContext context) {
    final (label, bg) = switch (type) {
      GrowBadgeType.novo => ('NOVO', GrowColors.badgeNew),
      GrowBadgeType.maisVendido => ('MAIS VENDIDO', GrowColors.badgeBestSeller),
      GrowBadgeType.discount => (customLabel ?? '-25%', GrowColors.discount),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
