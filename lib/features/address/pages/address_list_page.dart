import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/routing/app_routes.dart';
import 'package:growstore/core/theme/widgets/empty_state_widget.dart';
import 'package:growstore/core/theme/widgets/error_state_widget.dart';
import 'package:growstore/core/theme/widgets/loading_widget.dart';
import 'package:growstore/features/address/stores/address_store.dart';
import 'package:growstore/features/address/widgets/address_card_widget.dart';
import 'package:growstore/features/checkout/stores/checkout_store.dart';
import 'package:growstore/features/orders/widgets/order_header.dart';
import 'package:growstore/features/orders/widgets/order_layout_colors.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  final _addressStore = GetIt.I<AddressStore>();
  final _checkoutStore = GetIt.I<CheckoutStore>();

  @override
  void initState() {
    super.initState();
    _addressStore.loadAddresses();
  }

  Widget _buildBody(OrderLayoutColors colors) {
    return Observer(
      builder: (_) {
        if (_addressStore.isLoading) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: 3,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, _) {
              return const GrowCartItemSkeleton();
            },
          );
        }

        if (_addressStore.error != null) {
          return GrowErrorState(
            description: _addressStore.error,
            onRetry: _addressStore.loadAddresses,
          );
        }

        if (_addressStore.addresses.isEmpty) {
          return const GrowEmptyState(
            icon: Icons.location_off_outlined,
            title: 'Nenhum endereço cadastrado',
            description: 'Adicione um endereço para facilitar suas compras.',
          );
        }

        return Observer(
          builder: (_) {
            final selectedId = _checkoutStore.selectedAddressId;
            final addresses = _addressStore.addresses;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _addressStore.addresses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final address = addresses[index];

                return AddressCardWidget(
                  address: address,

                  selected: selectedId == address.id,

                  onSelect: () {
                    _checkoutStore.selectAddress(address.id);
                    Navigator.pop(context);
                  },

                  onSetDefault: () {
                    _addressStore.setDefaultAddress(address.id);
                  },

                  onDelete: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('Remover endereço'),
                          content: const Text(
                            'Deseja realmente remover este endereço?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Remover'),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      await _addressStore.removeAddress(address.id);
                    }
                  },

                  onEdit: () {},
                );
              },
            );
          },
        );
      },
    );
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, AppRoutes.addressForm);

            _addressStore.loadAddresses();
          },
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add_rounded),
        ),

        body: Column(
          children: [
            OrderHeader(
              title: "Meus endereços",
              colors: colors,
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(child: _buildBody(colors)),
          ],
        ),
      ),
    );
  }
}
