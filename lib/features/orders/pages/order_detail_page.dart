import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/cart/utils/cart_currency.dart';
import 'package:growstore/features/home/widgets/home_bottom_navigation.dart';
import 'package:growstore/features/orders/models/order_item_model.dart';
import 'package:growstore/features/orders/models/order_model.dart';
import 'package:growstore/features/orders/models/order_status.dart';
import 'package:growstore/features/orders/repositories/order_repository.dart';
import 'package:growstore/features/orders/widgets/order_header.dart';
import 'package:growstore/features/orders/widgets/order_layout_colors.dart';
import 'package:growstore/shared/widgets/cached_product_image.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key, required this.orderId});

  final String orderId;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final OrderRepository _repository = GetIt.I.isRegistered<OrderRepository>()
      ? GetIt.I<OrderRepository>()
      : OrderRepository();
  final CartStore? _cartStore = GetIt.I.isRegistered<CartStore>()
      ? GetIt.I<CartStore>()
      : null;

  late Future<OrderModel?> _orderFuture;

  @override
  void initState() {
    super.initState();
    _orderFuture = _repository.getOrderById(widget.orderId);
  }

  void _reload() {
    setState(() {
      _orderFuture = _repository.getOrderById(widget.orderId);
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
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/orders',
          (route) => route.settings.name == '/home',
        );
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
              title: 'Detalhe do Pedido',
              colors: colors,
              onBack: () => Navigator.of(context).pop(),
            ),
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
    return FutureBuilder<OrderModel?>(
      future: _orderFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(color: colors.primary),
          );
        }

        if (snapshot.hasError) {
          return _OrderDetailState(
            colors: colors,
            icon: Icons.wifi_off_rounded,
            title: 'Erro ao carregar pedido',
            description: 'Tente novamente em alguns instantes.',
            onRetry: _reload,
          );
        }

        final order = snapshot.data;

        if (order == null) {
          return _OrderDetailState(
            colors: colors,
            icon: Icons.receipt_long_outlined,
            title: 'Pedido nao encontrado',
            description: 'O pedido selecionado nao esta salvo neste aparelho.',
            onRetry: _reload,
          );
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            _OrderSummaryCard(order: order, colors: colors),
            const SizedBox(height: 14),
            _OrderStatusTracker(status: order.status, colors: colors),
            const SizedBox(height: 18),
            _SectionTitle(title: 'Itens do pedido', colors: colors),
            const SizedBox(height: 10),
            for (final item in order.items) ...[
              _OrderItemCard(item: item, colors: colors),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 4),
            _OrderTotalsCard(order: order, colors: colors),
          ],
        );
      },
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({required this.order, required this.colors});

  final OrderModel order;
  final OrderLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                  'Pedido #${_shortId(order.id)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.syne(
                    color: colors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 27 / 22,
                  ),
                ),
              ),
              _StatusChip(status: order.status, colors: colors),
            ],
          ),
          const SizedBox(height: 12),
          _SummaryLine(
            icon: Icons.calendar_today_rounded,
            label: _formatDate(order.createdAt),
            colors: colors,
          ),
          const SizedBox(height: 8),
          _SummaryLine(
            icon: Icons.shopping_bag_outlined,
            label: '${order.totalItems} itens',
            colors: colors,
          ),
          const SizedBox(height: 14),
          Text(
            cartCurrency(order.total),
            style: GoogleFonts.syne(
              color: colors.primary,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 34 / 28,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({
    required this.icon,
    required this.label,
    required this.colors,
  });

  final IconData icon;
  final String label;
  final OrderLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: colors.textSecondary, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: colors.textSecondary,
              fontSize: 14,
              height: 18 / 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _OrderStatusTracker extends StatelessWidget {
  const _OrderStatusTracker({required this.status, required this.colors});

  final OrderStatus status;
  final OrderLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    final currentIndex = OrderStatus.values.indexOf(status);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Row(
        children: [
          for (var index = 0; index < OrderStatus.values.length; index++) ...[
            Expanded(
              child: _StatusStep(
                status: OrderStatus.values[index],
                active: index <= currentIndex,
                colors: colors,
              ),
            ),
            if (index < OrderStatus.values.length - 1)
              Container(
                width: 16,
                height: 2,
                margin: const EdgeInsets.only(bottom: 22),
                color: index < currentIndex
                    ? colors.primary
                    : colors.chipBackground,
              ),
          ],
        ],
      ),
    );
  }
}

class _StatusStep extends StatelessWidget {
  const _StatusStep({
    required this.status,
    required this.active,
    required this.colors,
  });

  final OrderStatus status;
  final bool active;
  final OrderLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    final color = active ? colors.primary : colors.textSecondary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? colors.primary : colors.chipBackground,
          ),
          child: Icon(
            active ? Icons.check_rounded : Icons.circle_outlined,
            size: 15,
            color: active ? Colors.white : colors.textSecondary,
          ),
        ),
        const SizedBox(height: 7),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            status.label,
            maxLines: 1,
            style: GoogleFonts.jetBrainsMono(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              height: 11 / 9,
            ),
          ),
        ),
      ],
    );
  }
}

class _OrderItemCard extends StatelessWidget {
  const _OrderItemCard({required this.item, required this.colors});

  final OrderItemModel item;
  final OrderLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 102),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 76,
              height: 76,
              child: GrowCachedProductImage(
                imageUrl: item.imageUrl,
                backgroundColor: colors.imageBackground,
                iconColor: colors.primary,
                padding: const EdgeInsets.all(8),
                cacheWidth: 180,
                cacheHeight: 180,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.syne(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 20 / 16,
                  ),
                ),
                if (item.variation.trim().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    item.variation,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: colors.textSecondary,
                      fontSize: 12,
                      height: 15 / 12,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colors.chipBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Qtd ${item.quantity}',
                        style: GoogleFonts.jetBrainsMono(
                          color: colors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          height: 12 / 10,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          cartCurrency(item.total),
                          style: GoogleFonts.syne(
                            color: colors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 22 / 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderTotalsCard extends StatelessWidget {
  const _OrderTotalsCard({required this.order, required this.colors});

  final OrderModel order;
  final OrderLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        children: [
          _TotalLine(label: 'Subtotal', value: order.subtotal, colors: colors),
          const SizedBox(height: 10),
          _TotalLine(label: 'Frete', value: order.shipping, colors: colors),
          if (order.discount > 0) ...[
            const SizedBox(height: 10),
            _TotalLine(
              label: 'Desconto',
              value: -order.discount,
              colors: colors,
            ),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, thickness: 1, color: colors.cardBorder),
          ),
          _TotalLine(
            label: 'Total',
            value: order.total,
            colors: colors,
            highlight: true,
          ),
        ],
      ),
    );
  }
}

class _TotalLine extends StatelessWidget {
  const _TotalLine({
    required this.label,
    required this.value,
    required this.colors,
    this.highlight = false,
  });

  final String label;
  final double value;
  final OrderLayoutColors colors;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final textColor = highlight ? colors.textPrimary : colors.textSecondary;
    final valueColor = highlight ? colors.primary : colors.textPrimary;
    final amount = value < 0
        ? '- ${cartCurrency(value.abs())}'
        : cartCurrency(value);

    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: highlight ? 16 : 14,
            fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
            height: 20 / 16,
          ),
        ),
        const Spacer(),
        Text(
          amount,
          style: GoogleFonts.syne(
            color: valueColor,
            fontSize: highlight ? 22 : 16,
            fontWeight: FontWeight.w700,
            height: highlight ? 27 / 22 : 20 / 16,
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.colors});

  final OrderStatus status;
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
        status.label,
        style: GoogleFonts.jetBrainsMono(
          color: colors.primary,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          height: 12 / 10,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.colors});

  final String title;
  final OrderLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.syne(
        color: colors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 24 / 20,
      ),
    );
  }
}

class _OrderDetailState extends StatelessWidget {
  const _OrderDetailState({
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

String _formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString();
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');

  return '$day/$month/$year as $hour:$minute';
}
