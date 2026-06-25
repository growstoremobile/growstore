import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

class CartHeaderWidget extends StatelessWidget {
  final int itemCount;

  const CartHeaderWidget({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Text(
            'MEU\nCARRINHO',
            style: TextStyle(
              fontSize: 34,
              height: 1.0,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              color: AppColors.deepNavy,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.growthGreen.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$itemCount ${itemCount == 1 ? 'ITEM' : 'ITENS'}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: AppColors.growthGreen,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
