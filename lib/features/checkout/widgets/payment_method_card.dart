import 'package:flutter/material.dart';

enum PaymentMethod { pix, card }

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? theme.colorScheme.primary : theme.dividerColor,
            width: selected ? 2 : 1,
          ),
          color: selected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surface,
        ),
        child: Row(
          children: [
            Icon(icon, size: 32),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),

                  const SizedBox(height: 4),

                  Text(subtitle, style: theme.textTheme.bodySmall),
                ],
              ),
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: selected
                  ? Icon(
                      Icons.check_circle,
                      key: const ValueKey(1),
                      color: theme.colorScheme.primary,
                    )
                  : const Icon(
                      Icons.radio_button_unchecked,
                      key: const ValueKey(2),
                      color: Colors.grey,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
