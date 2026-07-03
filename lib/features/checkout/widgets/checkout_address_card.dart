import 'package:flutter/material.dart';
import 'package:growstore/features/address/models/address_model.dart';

class CheckoutAddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback? onChange;

  const CheckoutAddressCard({super.key, required this.address, this.onChange});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: theme.colorScheme.primary,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    'Endereço de entrega',
                    style: theme.textTheme.titleMedium,
                  ),
                ),

                if (onChange != null)
                  TextButton(onPressed: onChange, child: const Text('Alterar')),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              address.name,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '${address.street}, ${address.number}',
              style: theme.textTheme.bodyLarge,
            ),

            if (address.complement.isNotEmpty)
              Text(address.complement, style: theme.textTheme.bodyMedium),

            Text(address.neighborhood, style: theme.textTheme.bodyMedium),

            Text(
              '${address.city} - ${address.state}',
              style: theme.textTheme.bodyMedium,
            ),

            Text('CEP ${address.cep}', style: theme.textTheme.bodyMedium),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Endereço selecionado',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
