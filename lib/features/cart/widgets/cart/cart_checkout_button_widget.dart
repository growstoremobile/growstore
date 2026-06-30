import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

class CartCheckoutButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const CartCheckoutButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.growthGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 0,
          ),
          child: const Text(
            'FINALIZAR COMPRA',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
