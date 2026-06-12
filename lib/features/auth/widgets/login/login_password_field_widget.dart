import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:growstore/shared/colors/colors.dart';
import 'package:growstore/features/auth/stores/login/login_store.dart';

class LoginPasswordFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmitted;
  final LoginStore store;

  const LoginPasswordFieldWidget({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 8.0, right: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Senha',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepNavy,
                ),
              ),
            ],
          ),
        ),
        Observer(
          builder: (_) {
            return TextFormField(
              controller: controller,
              obscureText: !store.showPassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSubmitted(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua senha';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: '••••••••',
                hintStyle: TextStyle(
                  color: AppColors.outline.withValues(alpha: 0.6),
                ),
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColors.onSurfaceVariant,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    store.showPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.onSurfaceVariant,
                  ),
                  onPressed: store.toggleShowPassword,
                ),
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
                  borderSide: const BorderSide(
                    color: AppColors.outline,
                    width: 0.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
