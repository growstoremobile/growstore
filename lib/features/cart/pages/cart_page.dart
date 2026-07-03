import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/routing/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/cart/utils/cart_currency.dart';
import 'package:growstore/features/cart/widgets/cart/cart_item_widget.dart';
import 'package:growstore/features/cart/widgets/cart/cart_styles.dart';
import 'package:growstore/features/home/widgets/home_bottom_navigation.dart';
import 'package:growstore/features/orders/widgets/order_header.dart';
import 'package:growstore/features/orders/widgets/order_layout_colors.dart';
import 'package:growstore/features/orders/repositories/order_repository.dart';
import 'package:growstore/features/profile/models/address_model.dart';
import 'package:growstore/features/profile/repositories/address_repository.dart';
import 'package:growstore/features/cart/widgets/cart/cart_checkout_button_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _cartStore = GetIt.I<CartStore>();

  /*final CartStore _cartStore = GetIt.I.isRegistered<CartStore>()
      ? GetIt.I<CartStore>()
      : CartStore();*/

  @override
  void initState() {
    super.initState();
    _cartStore.loadCart();
    //_loadDefaultAddress();
  }

  /*Future<void> _loadDefaultAddress() async {
    final address = await _addressRepository.getDefaultAddress();

    if (!mounted) return;

    setState(() {
      _defaultAddress = address;
    });
  }  */

  void _handleBottomNavigation(BuildContext context, String label) {
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
        break;
      case 'Favoritos':
        Navigator.of(context).pushNamed('/favorites');
        break;
      case 'Pedidos':
        Navigator.of(context).pushNamed('/orders');
        break;
    }
  }

  void _handleRemove(CartItemModel item) {
    _cartStore.removeItem(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} removido do carrinho')),
    );
  }

  void _handleCheckout() {
    Navigator.pushNamed(context, AppRoutes.checkout);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = CartLayoutColors.resolve(isDark);
    final headerColors = OrderLayoutColors.resolve(isDark);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: headerColors.statusBar,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: colors.bottomBar,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: colors.page,
        body: Column(
          children: [
            OrderHeader(title: 'Carrinho', colors: headerColors),
            Expanded(
              child: Observer(builder: (_) => _buildCartContent(colors)),
            ),
            CartCheckoutButtonWidget(onPressed: _handleCheckout),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent(CartLayoutColors colors) {
    if (_cartStore.isLoading) {
      return Center(child: CircularProgressIndicator(color: colors.primary));
    }

    if (_cartStore.items.isEmpty) {
      return _CartEmptyState(colors: colors);
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      itemCount: _cartStore.items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 9),
      itemBuilder: (context, index) {
        final item = _cartStore.items[index];

        return Dismissible(
          key: ValueKey('${item.id}-${item.variation}'),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => _handleRemove(item),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(Icons.delete_outline, color: Colors.white),
          ),
          child: CartItemWidget(
            item: item,
            colors: colors,
            onIncrement: () => _cartStore.incrementQuantity(item),
            onDecrement: () => _cartStore.decrementQuantity(item),
          ),
        );
      },
    );
  }
}

/*class _CartCheckoutPanel extends StatelessWidget {
  const _CartCheckoutPanel({
    required this.colors,
    required this.total,
    required this.onCheckout,
  });

  final CartLayoutColors colors;
  final double total;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.page,
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Total:',
                style: GoogleFonts.syne(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  height: 26 / 22,
                  color: colors.textPrimary,
                ),
              ),
              const Spacer(),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    'US\$: ${cartCurrencyValue(total)}',
                    maxLines: 1,
                    style: GoogleFonts.syne(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 29 / 24,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () => onCheckout(),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: colors.primary,
                foregroundColor: colors.buttonText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: Text(
                'Finalizar a compra',
                style: GoogleFonts.syne(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  height: 28 / 23,
                  color: colors.buttonText,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
class _CartEmptyState extends StatelessWidget {
  const _CartEmptyState({required this.colors});

  final CartLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 64, color: colors.primary),
          const SizedBox(height: 16),
          Text(
            'Seu carrinho esta vazio',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
