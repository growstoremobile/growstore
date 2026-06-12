import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

class LoginGoogleButtonWidget extends StatelessWidget {
  const LoginGoogleButtonWidget({super.key});

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
            color: AppColors.deepNavy,
          ),
        ),
        label: const Text(
          'Google Account',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.deepNavy,
          side: BorderSide(
            color: AppColors.outline.withValues(alpha: 0.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
      ),
    );
  }
}
