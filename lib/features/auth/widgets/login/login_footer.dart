import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors_login_page.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Não tem uma conta? ',
          style: TextStyle(
            fontSize: 14,
            color: LoginPageColors.onSurfaceVariant,
          ),
        ),
        InkWell(
          onTap: () {
            // TODO: Navegar para cadastro
          },
          child: const Text(
            'Cadastre-se',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: LoginPageColors.growthGreen,
            ),
          ),
        ),
      ],
    );
  }
}
