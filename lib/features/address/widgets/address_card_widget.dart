import 'package:flutter/material.dart';

import 'package:growstore/features/address/models/address_model.dart';

class AddressCardWidget extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSelect;
  final VoidCallback onSetDefault;
  final bool selected;

  const AddressCardWidget({
    super.key,
    required this.address,
    required this.onEdit,
    required this.onDelete,
    required this.onSelect,
    required this.onSetDefault,
    required this.selected,
  });

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: const Text('Usar neste pedido'),
                onTap: () {
                  Navigator.pop(context);
                  onSelect();
                },
              ),

              ListTile(
                leading: const Icon(Icons.star_outline),
                title: const Text('Definir como principal'),
                onTap: () {
                  Navigator.pop(context);
                  onSetDefault();
                },
              ),

              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Editar'),
                onTap: () {
                  Navigator.pop(context);
                  onEdit();
                },
              ),

              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Excluir'),
                onTap: () {
                  Navigator.pop(context);
                  onDelete();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selected
              ? theme.colorScheme.primary
              : theme.colorScheme.outline,
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      address.name,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: onSelect,
                    icon: Icon(
                      selected
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: selected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outline,
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => _showOptions(context),
                  ),
                ],
              ),

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
              const SizedBox(height: 16),

              if (address.isDefault)
                Chip(
                  label: const Text('Principal'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  side: BorderSide.none,
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
