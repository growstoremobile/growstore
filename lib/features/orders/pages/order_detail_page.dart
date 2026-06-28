import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/orders/stores/order_store.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = GetIt.I<OrderStore>().lastOrder;

    if (order == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Pedido')),
        body: const Center(child: Text('Pedido não encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pedido realizado')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.check_circle, color: Colors.green, size: 80),
            ),

            const SizedBox(height: 16),

            Center(
              child: Text(
                'Pedido realizado com sucesso!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            const SizedBox(height: 8),

            Center(child: Text('Pedido #${order.id}')),

            const SizedBox(height: 32),

            Text(
              'Endereço de entrega',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.address.name),
                    Text('${order.address.street}, ${order.address.number}'),
                    Text(order.address.neighborhood),
                    Text('${order.address.city} - ${order.address.state}'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Itens do pedido',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 12),

            ...order.items.map(
              (item) => ListTile(
                title: Text(item.name),
                subtitle: Text(item.variation),
                trailing: Text('x${item.quantity}'),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildRow('Subtotal', order.subtotal),
                    _buildRow('Frete', order.shipping),
                    _buildRow('Desconto', -order.discount),
                    const Divider(),
                    _buildRow('Total', order.total, bold: true),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Voltar para a loja'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildRow(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            'R\$ ${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
