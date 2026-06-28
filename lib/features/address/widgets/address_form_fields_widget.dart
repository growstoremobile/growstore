import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddressFormFieldsWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController cepController;
  final TextEditingController streetController;
  final TextEditingController numberController;
  final TextEditingController complementController;
  final TextEditingController neighborhoodController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final VoidCallback onCepChanged;

  const AddressFormFieldsWidget({
    super.key,
    required this.nameController,
    required this.cepController,
    required this.streetController,
    required this.numberController,
    required this.complementController,
    required this.neighborhoodController,
    required this.cityController,
    required this.stateController,
    required this.onCepChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Nome do endereço',
            hintText: 'Ex: Casa, Trabalho',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe o nome do endereço';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: cepController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'CEP'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter(ponto: false),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe o CEP';
            }
            return null;
          },
          onChanged: (value) {
            if (value.replaceAll(RegExp(r'[^0-9]'), '').length == 8) {
              onCepChanged();
            }
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: streetController,
          decoration: const InputDecoration(labelText: 'Rua'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe a rua';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: numberController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Número'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe o número';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: complementController,
          decoration: const InputDecoration(labelText: 'Complemento'),
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: neighborhoodController,
          decoration: const InputDecoration(labelText: 'Bairro'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe o bairro';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: cityController,
          decoration: const InputDecoration(labelText: 'Cidade'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe a cidade';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: stateController,
          decoration: const InputDecoration(labelText: 'Estado'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe o estado';
            }
            return null;
          },
        ),
      ],
    );
  }
}
