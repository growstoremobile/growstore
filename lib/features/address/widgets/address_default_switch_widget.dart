import 'package:flutter/material.dart';

class AddressDefaultSwitchWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AddressDefaultSwitchWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: const Text('Definir como endereço principal'),
      contentPadding: EdgeInsets.zero,
    );
  }
}
