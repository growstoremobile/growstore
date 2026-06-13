import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

class RegisterFooterWidget extends StatelessWidget {
  const RegisterFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Já possui uma conta? ',
          style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant,),
        ),
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Text(
            'Entrar',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
