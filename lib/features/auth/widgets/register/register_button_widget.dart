import 'package:flutter/material.dart';

class RegisterButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const RegisterButtonWidget({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.outline.withValues(alpha: 0.28),
          disabledForegroundColor: colorScheme.onSurfaceVariant,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: theme.textTheme.labelLarge?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: colorScheme.onPrimary,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Cadastrar',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 20,
                    color: colorScheme.onPrimary,
                  ),
                ],
              ),
      ),
    );
  }
}
