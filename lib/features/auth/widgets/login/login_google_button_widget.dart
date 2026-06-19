import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

class LoginGoogleButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  const LoginGoogleButtonWidget({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,

        child: isLoading
            ? Container(
                alignment: AlignmentGeometry.center,
                height: 22,
                width: 22,
                child: const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Image.asset(
                        "assets/images/google.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),

                  const Text(
                    "Continuar com o Google",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
