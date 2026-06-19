import 'package:flutter/material.dart';

import '../colors_theme.dart';
import '../typography_theme.dart';

/// Widget de incremento de quantidade — o controle "− 1 +" exibido no carrinho.

/// Uso:
/// ```dart
/// GrowQuantityStepper(
/// quantity: _qty,
/// onDecrement: () => setState(() => _qty--),
/// onIncrement: () => setState(() => _qty++),
/// )
/// ```
class GrowQuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const GrowQuantityStepper({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? GrowColors.darkBorder : GrowColors.lightBorder;
    final textColor = isDark
        ? GrowColors.darkTextPrimary
        : GrowColors.lightTextPrimary;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(icon: Icons.remove, onTap: onDecrement),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              '$quantity',
              style: TextStyle(
                fontFamily: GrowTypography.fontFamily,
                fontSize: GrowTypography.bodyLarge,
                fontWeight: GrowTypography.bold,
                color: textColor,
              ),
            ),
          ),
          _StepButton(icon: Icons.add, onTap: onIncrement),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StepButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 16, color: GrowColors.primary),
      ),
    );
  }
}
