import 'package:flutter/material.dart';

class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.18),
            ),
          ),
          child: Icon(
            Icons.person_add_alt_1_rounded,
            color: colorScheme.onPrimaryContainer,
            size: 26,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Crie sua conta',
          textAlign: TextAlign.center,
          style: theme.textTheme.displayMedium?.copyWith(
            color: colorScheme.onSurface,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Preencha seus dados para acessar os produtos exclusivos da Grow Store.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.32,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}
