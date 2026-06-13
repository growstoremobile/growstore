import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

class RegisterAppBarWidget extends StatelessWidget {
  const RegisterAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.onSurfaceVariant,
            ),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Voltar',
          ),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.eco, color: AppColors.growthGreen),
              SizedBox(width: 8),
              Text(
                'Grow Store',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.growthGreen,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(width: 48), // Espaçador para simetria
        ],
      ),
    );
  }
}
