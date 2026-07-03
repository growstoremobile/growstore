import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/routing/app_routes.dart';
import 'package:growstore/features/address/stores/address_store.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/checkout/stores/checkout_store.dart';
import 'package:growstore/features/checkout/stores/payment_store.dart';
import 'package:growstore/features/checkout/widgets/checkout_address_card.dart';
import 'package:growstore/features/checkout/widgets/checkout_item_card.dart';
import 'package:growstore/features/checkout/widgets/checkout_summary_card.dart';
import 'package:growstore/features/checkout/widgets/payment_method_card.dart'
    hide PaymentMethod;
import 'package:growstore/features/orders/models/order_item_model.dart';
import 'package:growstore/features/orders/models/order_model.dart';
import 'package:growstore/features/orders/models/order_status.dart';
import 'package:growstore/features/orders/stores/order_store.dart';
import 'package:growstore/features/orders/widgets/order_header.dart';
import 'package:growstore/features/orders/widgets/order_layout_colors.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _addressStore = GetIt.I<AddressStore>();
  final _checkoutStore = GetIt.I<CheckoutStore>();
  final _cartStore = GetIt.I<CartStore>();
  final _orderStore = GetIt.I<OrderStore>();

  final _paymentStore = GetIt.I<PaymentStore>();
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    if (_addressStore.addresses.isEmpty) {
      await _addressStore.loadAddresses();
    }

    if (_cartStore.items.isEmpty) {
      await _cartStore.loadCart();
    }

    _checkoutStore.initialize();
  }

  Future<bool> _finishOrder() async {
    try {
      final address = _checkoutStore.selectedAddress;

      if (address == null || _cartStore.items.isEmpty) {
        return false;
      }

      final order = OrderModel(
        id: FirebaseFirestore.instance.collection('orders').doc().id,
        address: address,
        items: _cartStore.items
            .map((e) => OrderItemModel.fromCartItem(e))
            .toList(),

        subtotal: _cartStore.subtotal,
        shipping: _cartStore.shipping,
        discount: _cartStore.discount,
        total: _cartStore.total,

        createdAt: DateTime.now(),
        status: OrderStatus.pending,
      );

      await _orderStore.createOrder(order);

      return true;
    } catch (e) {
      return false;
    }
  }

  Widget _buildBody(OrderLayoutColors colors) {
    return Observer(
      builder: (_) {
        final address = _checkoutStore.selectedAddress;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (address == null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_off_outlined,
                          size: 56,
                          color: Theme.of(context).colorScheme.primary,
                        ),

                        const SizedBox(height: 16),

                        Text(
                          'Nenhum endereço selecionado',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await Navigator.pushNamed(
                                context,
                                AppRoutes.addressList,
                              );

                              _checkoutStore.initialize();
                            },
                            icon: const Icon(Icons.location_on_outlined),
                            label: const Text('Selecionar endereço'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                CheckoutAddressCard(
                  address: address,
                  onChange: () async {
                    await Navigator.pushNamed(context, AppRoutes.addressList);
                  },
                ),

              const SizedBox(height: 24),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Itens do pedido',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              const SizedBox(height: 12),

              ..._cartStore.items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CheckoutItemCard(item: item),
                ),
              ),

              const SizedBox(height: 24),

              CheckoutSummaryCard(
                subtotal: _cartStore.subtotal,
                shipping: _cartStore.shipping,
                discount: _cartStore.discount,
                total: _cartStore.total,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Forma de pagamento',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              const SizedBox(height: 12),

              Observer(
                builder: (_) {
                  return PaymentMethodCard(
                    title: 'PIX',
                    subtitle: 'Pagamento instantâneo',
                    icon: Icons.pix,
                    selected: _paymentStore.selectedMethod == PaymentMethod.pix,
                    onTap: () {
                      _paymentStore.selectMethod(PaymentMethod.pix);
                    },
                  );
                },
              ),

              const SizedBox(height: 12),

              Observer(
                builder: (_) {
                  return PaymentMethodCard(
                    title: 'Cartão',
                    subtitle: 'Até 12x',
                    icon: Icons.credit_card,
                    selected:
                        _paymentStore.selectedMethod == PaymentMethod.card,
                    onTap: () {
                      _paymentStore.selectMethod(PaymentMethod.card);
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final success = await _finishOrder();

                    if (!mounted) return;

                    if (success) {
                      Navigator.pushReplacementNamed(
                        // ignore: use_build_context_synchronously
                        context,
                        AppRoutes.orderSuccess,
                      );

                      _cartStore.clearCart();
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Não foi possível finalizar o pedido.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Finalizar pedido'),
                ),
              ),
            ],
          ),
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
        body: Column(
          children: [
            OrderHeader(
              title: "Finalizar pedido",
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
