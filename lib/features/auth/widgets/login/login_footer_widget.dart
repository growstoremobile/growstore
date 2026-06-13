import 'package:flutter/material.dart';
import 'package:growstore/features/auth/pages/register_page.dart';
import 'package:growstore/shared/colors/colors.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Não tem uma conta? ',
          style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            );
          },
          child: const Text(  
            'Cadastre-se',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.growthGreen,
            ),
          ),
        ),
      ],
    );
  }
}
