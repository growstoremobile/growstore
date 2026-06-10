import 'package:flutter/material.dart';

import '../colors_theme.dart';

enum GrowStoreBadgeType { novo, maisVendido, discount }

/// Sobreposição de etiqueta para cartões de produtos.

/// /// Uso:
/// ```dart
/// GrowStoreBadge(type: GrowStoreBadgeType.novo)
/// GrowStoreBadge(type: GrowStoreBadgeType.maisVendido)
/// GrowStoreBadge(type: GrowStoreBadgeType.discount, customLabel: '-25%')
/// ```
class GrowStoreBadge extends StatelessWidget {
  final GrowStoreBadgeType type;

  /// Only used when [type] is [GrowStoreBadgeType.discount].
  final String? customLabel;

  const GrowStoreBadge({super.key, required this.type, this.customLabel});

  @override
  Widget build(BuildContext context) {
    final (label, bg) = switch (type) {
      GrowStoreBadgeType.novo => ('NOVO', GrowStoreColors.badgeNew),
      GrowStoreBadgeType.maisVendido => (
        'MAIS VENDIDO',
        GrowStoreColors.badgeBestSeller,
      ),
      GrowStoreBadgeType.discount => (
        customLabel ?? '-25%',
        GrowStoreColors.discount,
      ),
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
