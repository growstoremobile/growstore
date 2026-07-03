import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/home/widgets/home_bottom_navigation.dart';
import 'package:growstore/features/orders/widgets/order_header.dart';
import 'package:growstore/features/orders/widgets/order_layout_colors.dart';
import 'package:growstore/features/profile/models/address_model.dart';
import 'package:growstore/features/profile/repositories/address_repository.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({super.key});

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  final AddressRepository _repository =
      GetIt.I.isRegistered<AddressRepository>()
      ? GetIt.I<AddressRepository>()
      : AddressRepository();
  final CartStore? _cartStore = GetIt.I.isRegistered<CartStore>()
      ? GetIt.I<CartStore>()
      : null;

  late Future<List<AddressModel>> _addressesFuture;

  @override
  void initState() {
    super.initState();
    _addressesFuture = _repository.getAddresses();
  }

  void _reload() {
    setState(() {
      _addressesFuture = _repository.getAddresses();
    });
  }

  Future<void> _openForm({AddressModel? address}) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return _AddressFormSheet(repository: _repository, address: address);
      },
    );

    if (saved == true) _reload();
  }

  Future<void> _deleteAddress(AddressModel address) async {
    await _repository.deleteAddress(address.id);
    _reload();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Endereco removido com sucesso.')),
    );
  }

  Future<void> _setDefaultAddress(AddressModel address) async {
    await _repository.setDefaultAddress(address.id);
    _reload();
  }

  void _handleBottomNavigation(String label) {
    switch (label) {
      case 'Inicio':
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/home', (route) => false);
        break;
      case 'Categorias':
        Navigator.of(context).pushNamed('/categories');
        break;
      case 'Carrinho':
        Navigator.of(context).pushNamed('/cart');
        break;
      case 'Favoritos':
        Navigator.of(context).pushNamed('/favorites');
        break;
      case 'Pedidos':
        Navigator.of(context).pushNamed('/orders');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = OrderLayoutColors.resolve(
      Theme.of(context).brightness == Brightness.dark,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: colors.statusBar,
        statusBarIconBrightness: colors.isDark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: colors.isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: colors.bottomBar,
        systemNavigationBarIconBrightness: colors.isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: colors.page,
        body: Column(
          children: [
            OrderHeader(
              title: 'Enderecos',
              colors: colors,
              onBack: () => Navigator.of(context).pop(),
              trailing: IconButton(
                tooltip: 'Adicionar endereco',
                onPressed: () => _openForm(),
                icon: Icon(
                  Icons.add_location_alt_rounded,
                  color: colors.textPrimary,
                ),
              ),
            ),
            Expanded(child: _buildBody(colors)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openForm(),
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add_rounded),
        ),
        bottomNavigationBar: HomeBottomNavigation(
          selectedLabel: '',
          cartItemCount: _cartStore?.totalItems ?? 0,
          showCartBadge: false,
          onTap: _handleBottomNavigation,
        ),
      ),
    );
  }

  Widget _buildBody(OrderLayoutColors colors) {
    return FutureBuilder<List<AddressModel>>(
      future: _addressesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(color: colors.primary),
          );
        }

        if (snapshot.hasError) {
          return _AddressState(
            colors: colors,
            icon: Icons.wifi_off_rounded,
            title: 'Erro ao carregar enderecos',
            description: 'Tente novamente em alguns instantes.',
            onRetry: _reload,
          );
        }

        final addresses = snapshot.data ?? const [];

        if (addresses.isEmpty) {
          return _AddressState(
            colors: colors,
            icon: Icons.location_on_outlined,
            title: 'Nenhum endereco salvo',
            description: 'Cadastre um endereco para finalizar compras.',
            onRetry: () => _openForm(),
            actionLabel: 'Adicionar endereco',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          itemCount: addresses.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final address = addresses[index];

            return _AddressCard(
              address: address,
              colors: colors,
              onEdit: () => _openForm(address: address),
              onDelete: () => _deleteAddress(address),
              onSetDefault: address.isDefault
                  ? null
                  : () => _setDefaultAddress(address),
            );
          },
        );
      },
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.address,
    required this.colors,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  final AddressModel address;
  final OrderLayoutColors colors;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onSetDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  address.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.syne(
                    color: colors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 22 / 18,
                  ),
                ),
              ),
              if (address.isDefault)
                _DefaultChip(colors: colors)
              else
                TextButton(onPressed: onSetDefault, child: const Text('Usar')),
              IconButton(
                tooltip: 'Editar',
                onPressed: onEdit,
                icon: Icon(Icons.edit_outlined, color: colors.textSecondary),
              ),
              IconButton(
                tooltip: 'Remover',
                onPressed: onDelete,
                icon: Icon(Icons.delete_outline, color: colors.primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            address.recipient,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: colors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 18 / 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            address.summary,
            style: GoogleFonts.inter(
              color: colors.textSecondary,
              fontSize: 13,
              height: 18 / 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultChip extends StatelessWidget {
  const _DefaultChip({required this.colors});

  final OrderLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: colors.chipBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Padrao',
        style: GoogleFonts.inter(
          color: colors.primary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          height: 13 / 11,
        ),
      ),
    );
  }
}

class _AddressFormSheet extends StatefulWidget {
  const _AddressFormSheet({required this.repository, this.address});

  final AddressRepository repository;
  final AddressModel? address;

  @override
  State<_AddressFormSheet> createState() => _AddressFormSheetState();
}

class _AddressFormSheetState extends State<_AddressFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _labelController;
  late final TextEditingController _recipientController;
  late final TextEditingController _streetController;
  late final TextEditingController _numberController;
  late final TextEditingController _complementController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _zipCodeController;
  late bool _isDefault;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final address = widget.address;

    _labelController = TextEditingController(text: address?.label ?? '');
    _recipientController = TextEditingController(
      text: address?.recipient ?? '',
    );
    _streetController = TextEditingController(text: address?.street ?? '');
    _numberController = TextEditingController(text: address?.number ?? '');
    _complementController = TextEditingController(
      text: address?.complement ?? '',
    );
    _cityController = TextEditingController(text: address?.city ?? '');
    _stateController = TextEditingController(text: address?.state ?? '');
    _zipCodeController = TextEditingController(text: address?.zipCode ?? '');
    _isDefault = address?.isDefault ?? true;
  }

  @override
  void dispose() {
    _labelController.dispose();
    _recipientController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_isSaving || !_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final address = AddressModel(
      id:
          widget.address?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      label: _labelController.text.trim(),
      recipient: _recipientController.text.trim(),
      street: _streetController.text.trim(),
      number: _numberController.text.trim(),
      complement: _complementController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim().toUpperCase(),
      zipCode: _zipCodeController.text.trim(),
      isDefault: _isDefault,
    );

    await widget.repository.saveAddress(address);

    if (!mounted) return;

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final colors = OrderLayoutColors.resolve(
      Theme.of(context).brightness == Brightness.dark,
    );
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Material(
        color: colors.page,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.address == null ? 'Novo endereco' : 'Editar endereco',
                  style: GoogleFonts.syne(
                    color: colors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 27 / 22,
                  ),
                ),
                const SizedBox(height: 16),
                _AddressTextField(
                  controller: _labelController,
                  label: 'Apelido',
                  icon: Icons.bookmark_outline,
                ),
                _AddressTextField(
                  controller: _recipientController,
                  label: 'Destinatario',
                  icon: Icons.person_outline_rounded,
                ),
                _AddressTextField(
                  controller: _streetController,
                  label: 'Rua',
                  icon: Icons.route_outlined,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _AddressTextField(
                        controller: _numberController,
                        label: 'Numero',
                        icon: Icons.tag_rounded,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: _AddressTextField(
                        controller: _complementController,
                        label: 'Complemento',
                        icon: Icons.apartment_rounded,
                        required: false,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _AddressTextField(
                        controller: _cityController,
                        label: 'Cidade',
                        icon: Icons.location_city_rounded,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _AddressTextField(
                        controller: _stateController,
                        label: 'UF',
                        icon: Icons.map_outlined,
                        textCapitalization: TextCapitalization.characters,
                      ),
                    ),
                  ],
                ),
                _AddressTextField(
                  controller: _zipCodeController,
                  label: 'CEP',
                  icon: Icons.local_post_office_outlined,
                  keyboardType: TextInputType.number,
                ),
                CheckboxListTile(
                  value: _isDefault,
                  onChanged: (value) {
                    setState(() => _isDefault = value ?? false);
                  },
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: colors.primary,
                  title: Text(
                    'Endereco padrao para entrega',
                    style: GoogleFonts.inter(color: colors.textPrimary),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Salvar endereco'),
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

class _AddressTextField extends StatelessWidget {
  const _AddressTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.words,
    this.required = true,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (!required) return null;

          return value == null || value.trim().isEmpty
              ? 'Campo obrigatorio'
              : null;
        },
      ),
    );
  }
}

class _AddressState extends StatelessWidget {
  const _AddressState({
    required this.colors,
    required this.icon,
    required this.title,
    required this.description,
    this.onRetry,
    this.actionLabel,
  });

  final OrderLayoutColors colors;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onRetry;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: colors.primary, size: 52),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.syne(
                color: colors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 28 / 22,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: colors.textSecondary,
                fontSize: 14,
                height: 20 / 14,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              FilledButton(
                onPressed: onRetry,
                style: FilledButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                ),
                child: Text(actionLabel ?? 'Tentar novamente'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
