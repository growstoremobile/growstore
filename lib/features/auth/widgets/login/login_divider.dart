import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors_login_page.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: LoginPageColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'OU ACESSE COM',
            style: TextStyle(
              fontSize: 12,
              color: LoginPageColors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: LoginPageColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
