import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/address/models/address_model.dart';
import 'package:growstore/features/address/stores/address_store.dart';
import 'package:growstore/features/address/widgets/address_form_fields_widget.dart';
import 'package:growstore/features/checkout/stores/checkout_store.dart';

class AddressFormPage extends StatefulWidget {
  const AddressFormPage({super.key});

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _store = GetIt.I<AddressStore>();
  final _checkoutStore = GetIt.I<CheckoutStore>();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cepController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  bool _isDefault = false;

  @override
  void initState() {
    super.initState();

    if (_store.addresses.isEmpty) {
      _isDefault = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cepController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();

    super.dispose();
  }

  Future<void> _searchCep() async {
    final cepLimpo = _cepController.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (cepLimpo.length != 8) return;

    final cep = await _store.searchCep(cepLimpo);

    if (cep != null) {
      _streetController.text = cep.street;
      _neighborhoodController.text = cep.neighborhood;
      _cityController.text = cep.city;
      _stateController.text = cep.state;
    }
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final isDefault = _store.addresses.isEmpty ? true : _isDefault;

    final address = AddressModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      cep: _cepController.text,
      street: _streetController.text,
      number: _numberController.text,
      neighborhood: _neighborhoodController.text,
      city: _cityController.text,
      state: _stateController.text,
      complement: _complementController.text.isEmpty
          ? ''
          : _complementController.text,
      isDefault: _isDefault,
    );

    await _store.addAddress(address);

    if (isDefault) {
      await _store.setDefaultAddress(address.id);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Endereço salvo com sucesso!')),
      );

      Navigator.pop(context);
      _checkoutStore.initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Endereço')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: AddressFormFieldsWidget(
                    nameController: _nameController,
                    cepController: _cepController,
                    streetController: _streetController,
                    numberController: _numberController,
                    complementController: _complementController,
                    neighborhoodController: _neighborhoodController,
                    cityController: _cityController,
                    stateController: _stateController,
                    onCepChanged: _searchCep,
                  ),
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  value: _isDefault,
                  onChanged: (value) {
                    setState(() {
                      _isDefault = value ?? false;
                    });
                  },
                  title: const Text('Definir como endereço principal'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveAddress,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_rounded),
                        SizedBox(width: 15),
                        Text("Salvar endereço"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
