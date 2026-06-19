import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

class RegisterTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final bool? obscureText;
  final VoidCallback? onToggleVisibility;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  const RegisterTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.obscureText,
    this.onToggleVisibility,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.deepNavy,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          validator:
              validator ??
              ((value) => (value == null || value.isEmpty)
                  ? 'Campo obrigatório'
                  : null),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.outline.withValues(alpha: 0.6),
            ),
            prefixIcon: Icon(prefixIcon, color: AppColors.outline, size: 20),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      (obscureText ?? true)
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.onSurfaceVariant,
                      size: 20,
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.outline.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.growthGreen,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
