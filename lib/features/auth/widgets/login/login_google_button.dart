import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors_login_page.dart';

class LoginGoogleButton extends StatelessWidget {
  const LoginGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () {
          // TODO: Implementar Login com Google
        },
        icon: const Text(
          'G',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: LoginPageColors.deepNavy,
          ),
        ),
        label: const Text(
          'Google Account',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: LoginPageColors.deepNavy,
          side: BorderSide(
            color: LoginPageColors.outline.withValues(alpha: 0.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
      ),
    );
  }
}
