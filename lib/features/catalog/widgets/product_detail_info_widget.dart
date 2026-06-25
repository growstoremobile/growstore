import 'package:flutter/material.dart';
import 'package:growstore/core/theme/growstore_theme.dart';

class ProductDetailInfoWidget extends StatelessWidget {
  final String name;
  final double price;

  const ProductDetailInfoWidget({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: textTheme.titleLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

          Text(
            'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}',
            style: textTheme.priceStyle,
          ),
        ],
      ),
    );
  }
}
