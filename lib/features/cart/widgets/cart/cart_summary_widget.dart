import 'package:flutter/material.dart';
import 'package:growstore/features/cart/utils/cart_currency.dart';
import 'package:growstore/features/cart/widgets/cart/cart_checkout_button_widget.dart';
import 'package:growstore/features/cart/widgets/cart/cart_styles.dart';
import 'package:growstore/features/cart/widgets/cart/cart_summary_line_widget.dart';
import 'package:growstore/shared/colors/colors.dart';

class CartSummaryWidget extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final String? couponCode;
  final VoidCallback onCheckout;

  const CartSummaryWidget({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
    required this.onCheckout,
    this.couponCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: cartCardDecoration(),
      child: Column(
        children: [
          CartSummaryLineWidget(
            label: 'Subtotal',
            value: cartCurrency(subtotal),
          ),
          const SizedBox(height: 12),
          CartSummaryLineWidget(
            label: 'Frete Express',
            value: cartCurrency(shipping),
          ),
          if (discount > 0) ...[
            const SizedBox(height: 12),
            CartSummaryLineWidget(
              label: 'Desconto${couponCode != null ? ' ($couponCode)' : ''}',
              value: '- ${cartCurrency(discount)}',
              valueColor: Colors.red.shade600,
            ),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              height: 1,
              color: AppColors.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          // "TOTAL" à esquerda; "R$" sobre o valor, ambos centralizados no bloco
          SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'TOTAL',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepNavy,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      r'R$',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.growthGreen,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      cartCurrencyValue(total),
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        color: AppColors.growthGreen,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CartCheckoutButtonWidget(onPressed: onCheckout),
        ],
      ),
    );
  }
}
