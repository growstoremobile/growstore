import 'package:flutter/material.dart';

class RegisterTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final bool? obscureText;
  final VoidCallback? onToggleVisibility;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
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
    this.textInputAction,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final borderRadius = BorderRadius.circular(8);
    final enabledBorderColor = colorScheme.outline.withValues(
      alpha: isDark ? 0.42 : 0.28,
    );
    final fillColor =
        theme.inputDecorationTheme.fillColor ??
        colorScheme.surfaceContainerHighest;

    OutlineInputBorder border(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      textCapitalization: textCapitalization,
      cursorColor: colorScheme.primary,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w500,
        height: 1.18,
        letterSpacing: 0,
      ),
      validator:
          validator ??
          ((value) =>
              (value == null || value.isEmpty) ? 'Campo obrigatório' : null),
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: theme.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
          height: 1.18,
          letterSpacing: 0,
        ),
        hintText: hint,
        hintStyle: theme.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.58),
          height: 1.18,
          letterSpacing: 0,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: colorScheme.onSurfaceVariant,
          size: 20,
        ),
        prefixIconConstraints: const BoxConstraints.tightFor(
          width: 44,
          height: 46,
        ),
        suffixIcon: isPassword
            ? IconButton(
                tooltip: (obscureText ?? true)
                    ? 'Mostrar senha'
                    : 'Ocultar senha',
                icon: Icon(
                  (obscureText ?? true)
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: colorScheme.onSurfaceVariant,
                  size: 20,
                ),
                onPressed: onToggleVisibility,
              )
            : null,
        suffixIconConstraints: const BoxConstraints.tightFor(
          width: 46,
          height: 46,
        ),
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 12,
        ),
        border: border(enabledBorderColor),
        enabledBorder: border(enabledBorderColor),
        focusedBorder: border(colorScheme.primary, width: 1.6),
        errorBorder: border(colorScheme.error),
        focusedErrorBorder: border(colorScheme.error, width: 1.6),
        errorMaxLines: 1,
      ),
    );
  }
}
