import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/routing/app_routes.dart';
import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/cart/widgets/cart/cart_coupon_widget.dart';
import 'package:growstore/features/cart/widgets/cart/cart_header_widget.dart';
import 'package:growstore/features/cart/widgets/cart/cart_item_widget.dart';
import 'package:growstore/features/cart/widgets/cart/cart_summary_widget.dart';
import 'package:growstore/shared/colors/colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _cartStore = GetIt.I<CartStore>();
  final _couponController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cartStore.loadCart();
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _handleRemove(CartItemModel item) {
    _cartStore.removeItem(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} removido do carrinho')),
    );
  }

  void _handleApplyCoupon() {
    _cartStore.applyCoupon(_couponController.text);
    FocusScope.of(context).unfocus();
    // Limpa o campo apenas quando o cupom foi aceito
    if (_cartStore.appliedCoupon != null) {
      _couponController.clear();
    }
  }

void _handleCheckout() {
  Navigator.pushNamed(
    context,
    AppRoutes.checkout,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Observer(
          builder: (_) {
            if (_cartStore.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_cartStore.items.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: AppColors.outline,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Seu carrinho está vazio',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CartHeaderWidget(itemCount: _cartStore.totalItems),
                  const SizedBox(height: 24),
                  for (final item in _cartStore.items) ...[
                    Dismissible(
                      key: ValueKey(item.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => _handleRemove(item),
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 24),
                        decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        ),
                      ),
                      child: CartItemWidget(
                        item: item,
                        onIncrement: () => _cartStore.incrementQuantity(item),
                        onDecrement: () => _cartStore.decrementQuantity(item),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 12),
                  CartCouponWidget(
                    controller: _couponController,
                    appliedCoupon: _cartStore.appliedCoupon,
                    couponError: _cartStore.couponError,
                    onApply: _handleApplyCoupon,
                    onRemove: _cartStore.removeCoupon,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${_cartStore.totalItems} itens no pedido',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CartSummaryWidget(
                    subtotal: _cartStore.subtotal,
                    shipping: _cartStore.shipping,
                    discount: _cartStore.discount,
                    total: _cartStore.total,
                    couponCode: _cartStore.appliedCoupon,
                    onCheckout: _handleCheckout,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
