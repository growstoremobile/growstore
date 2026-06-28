import 'package:flutter/material.dart';
import 'package:growstore/features/cart/models/cart_item_model.dart';

class CheckoutItemCard extends StatelessWidget {
  final CartItemModel item;

  const CheckoutItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: theme.textTheme.titleMedium),

                  const SizedBox(height: 4),

                  Text(item.variation, style: theme.textTheme.bodySmall),

                  const SizedBox(height: 8),

                  Text(
                    '${item.quantity}x R\$ ${item.price.toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),

            Text(
              'R\$ ${item.totalPrice.toStringAsFixed(2)}',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
