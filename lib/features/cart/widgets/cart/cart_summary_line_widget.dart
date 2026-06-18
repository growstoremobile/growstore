import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

class CartSummaryLineWidget extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const CartSummaryLineWidget({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.deepNavy,
          ),
        ),
      ],
    );
  }
}
