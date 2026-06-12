import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          // TODO: Alterar icon para o padrão da GrowStore
          child: const Icon(
            Icons.eco,
            color: AppColors.onPrimaryContainer,
            size: 36,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Grow Store',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.growthGreen,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Produtos exclusivos e customizados das marcas Growdev e Growlabs. Para quem vive e respira tecnologia.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
