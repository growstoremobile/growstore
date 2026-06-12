import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Crie sua conta',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.deepNavy,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Inicie sua jornada no ecossistema técnico da Grow Store.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }
}
