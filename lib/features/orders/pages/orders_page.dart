import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/cart/utils/cart_currency.dart';
import 'package:growstore/features/home/widgets/home_bottom_navigation.dart';
import 'package:growstore/features/orders/models/order_model.dart';
import 'package:growstore/features/orders/models/order_status.dart';
import 'package:growstore/features/orders/repositories/order_repository.dart';
import 'package:growstore/features/orders/widgets/order_header.dart';
import 'package:growstore/features/orders/widgets/order_layout_colors.dart';
import 'package:growstore/shared/widgets/cached_product_image.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final _repository = GetIt.I<OrderRepository>();

  final _cartStore = GetIt.I<CartStore>();

  late Future<List<OrderModel>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _repository.getOrders();
  }

  void _reload() {
    setState(() {
      _ordersFuture = _repository.getOrders();
    });
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
        _reload();
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
            OrderHeader(title: 'Pedidos', colors: colors),
            Expanded(child: _buildBody(colors)),
          ],
        ),
        bottomNavigationBar: HomeBottomNavigation(
          selectedLabel: 'Pedidos',
          cartItemCount: _cartStore?.totalItems ?? 0,
          showCartBadge: false,
          onTap: _handleBottomNavigation,
        ),
      ),
    );
  }

  Widget _buildBody(OrderLayoutColors colors) {
    return FutureBuilder<List<OrderModel>>(
      future: _ordersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(color: colors.primary),
          );
        }

        if (snapshot.hasError) {
          return _OrdersState(
            colors: colors,
            icon: Icons.wifi_off_rounded,
            title: 'Erro ao carregar pedidos',
            description: 'Tente novamente em alguns instantes.',
            onRetry: _reload,
          );
        }

        final orders = snapshot.data ?? const [];

        if (orders.isEmpty) {
          return _OrdersState(
            colors: colors,
            icon: Icons.shopping_bag_outlined,
            title: 'Nenhum pedido ainda',
            description:
                'Finalize uma compra para acompanhar o historico aqui.',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          itemCount: orders.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final order = orders[index];

            return _OrderHistoryCard(
              order: order,
              colors: colors,
              onTap: () => Navigator.of(
                context,
              ).pushNamed('/orderDetail', arguments: order.id),
            );
          },
        );
      },
    );
  }
}

class _OrderHistoryCard extends StatelessWidget {
  const _OrderHistoryCard({
    required this.order,
    required this.colors,
    required this.onTap,
  });

  final OrderModel order;
  final OrderLayoutColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.card,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: const BoxConstraints(minHeight: 116),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.cardBorder),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: GrowCachedProductImage(
                    imageUrl: order.items.isEmpty
                        ? null
                        : order.items.first.imageUrl,
                    backgroundColor: colors.imageBackground,
                    iconColor: colors.primary,
                    padding: const EdgeInsets.all(6),
                    cacheWidth: 220,
                    cacheHeight: 220,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _orderHeadline(order),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.syne(
                        color: colors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 22 / 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _orderSubtitle(order),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: colors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 16 / 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      cartCurrency(order.total),
                      style: GoogleFonts.syne(
                        color: colors.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 29 / 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrdersState extends StatelessWidget {
  const _OrdersState({
    required this.colors,
    required this.icon,
    required this.title,
    required this.description,
    this.onRetry,
  });

  final OrderLayoutColors colors;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onRetry;

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
                child: const Text('Tentar novamente'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String _shortId(String id) {
  if (id.length <= 6) return id;
  return id.substring(id.length - 6);
}

String _orderHeadline(OrderModel order) {
  final date = _formatDate(order.createdAt);

  return switch (order.status) {
    OrderStatus.delivered => 'Entregue dia $date',
    OrderStatus.shipped => 'Enviado dia $date',
    OrderStatus.processing => 'Em separacao dia $date',
    OrderStatus.pending => 'Pendente dia $date',
  };
}

String _orderSubtitle(OrderModel order) {
  if (order.items.isEmpty) return 'Pedido #${_shortId(order.id)}';

  final firstItem = order.items.first.name;
  if (order.items.length == 1) return firstItem;

  return '$firstItem e mais ${order.items.length - 1}';
}

String _formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString();

  return '$day/$month/$year';
}
