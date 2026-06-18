import 'package:flutter/material.dart';
import 'package:growstore/features/cart/widgets/cart/cart_styles.dart';
import 'package:growstore/shared/colors/colors.dart';

class CartCouponWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? appliedCoupon;
  final String? couponError;
  final VoidCallback onApply;
  final VoidCallback onRemove;

  const CartCouponWidget({
    super.key,
    required this.controller,
    required this.appliedCoupon,
    required this.couponError,
    required this.onApply,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isApplied = appliedCoupon != null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: cartCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CUPOM DE DESCONTO',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          if (isApplied)
            // Estado: cupom aplicado com sucesso
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppColors.growthGreen,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '$appliedCoupon aplicado',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onPrimaryContainer,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onRemove,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: AppColors.outline,
                  ),
                  child: const Text(
                    'Remover',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )
          else ...[
            // Estado: campo de entrada
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    textCapitalization: TextCapitalization.characters,
                    onSubmitted: (_) => onApply(),
                    decoration: InputDecoration(
                      hintText: 'Digite seu cupom',
                      filled: true,
                      fillColor: AppColors.surfaceLowest,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.outlineVariant.withValues(alpha: 0.6),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.growthGreen),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: onApply,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.growthGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'APLICAR',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            if (couponError != null) ...[
              const SizedBox(height: 6),
              Text(
                couponError!,
                style: TextStyle(fontSize: 12, color: Colors.red.shade600),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
