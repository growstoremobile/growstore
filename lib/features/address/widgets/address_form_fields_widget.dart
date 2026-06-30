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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nome do endereço',
              hintText: 'Casa, Trabalho...',
              prefixIcon: Icon(Icons.home_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe o nome do endereço';
              }
              return null;
            },
          ),

          const SizedBox(height: 25),

          TextFormField(
            controller: cepController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'CEP',
              hintText: '00000-000',

              prefixIcon: Icon(Icons.share_location_sharp),
            ),
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

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: streetController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Rua',
                    prefixIcon: Icon(Icons.location_on_outlined),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a rua';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Nº'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Obrigatório';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          TextFormField(
            controller: complementController,
            decoration: const InputDecoration(
              labelText: 'Complemento',
              hintText: 'Opcional',
              prefixIcon: Icon(Icons.apartment_outlined),
            ),
          ),

          const SizedBox(height: 25),

          TextFormField(
            controller: neighborhoodController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Bairro',
              prefixIcon: Icon(Icons.map_outlined),
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe o bairro';
              }
              return null;
            },
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: cityController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
                    prefixIcon: Icon(Icons.location_city_outlined),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a cidade';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: TextFormField(
                  controller: stateController,
                  readOnly: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'UF',

                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerHighest
                        .withValues(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'UF';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
