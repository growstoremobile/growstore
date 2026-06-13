import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

class RegisterDividerWidget extends StatelessWidget {
  const RegisterDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300])),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'ou continue com',
            style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }
}
