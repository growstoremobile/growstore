import 'package:flutter/material.dart';

class CheckoutSummaryCard extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;

  const CheckoutSummaryCard({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
  });

  Widget _row(
    BuildContext context,
    String title,
    double value, {
    bool bold = false,
  }) {
    final style = bold
        ? Theme.of(context).textTheme.titleMedium
        : Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: style),
          Text('R\$ ${value.toStringAsFixed(2)}', style: style),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Resumo do pedido',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            const SizedBox(height: 16),

            _row(context, 'Subtotal', subtotal),
            _row(context, 'Frete', shipping),

            if (discount > 0) _row(context, 'Desconto', -discount),

            const Divider(height: 32),

            _row(context, 'Total', total, bold: true),
          ],
        ),
      ),
    );
  }
}
