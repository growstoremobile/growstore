import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/cart/widgets/cart/cart_feedback_snackbar.dart';
import 'package:growstore/features/catalog/stores/product_detail_store.dart';
import 'package:growstore/features/catalog/widgets/product_detail_image_widget.dart';
import 'package:growstore/features/catalog/widgets/product_detail_info_widget.dart';
import 'package:growstore/features/catalog/widgets/product_detail_variants_widget.dart';
import 'package:growstore/features/orders/widgets/order_header.dart';
import 'package:growstore/features/orders/widgets/order_layout_colors.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late final ProductDetailStore _store;
  late final CartStore _cartStore;

  @override
  void initState() {
    super.initState();
    _store = GetIt.I<ProductDetailStore>();
    _cartStore = GetIt.I<CartStore>();
    _store.loadProduct(widget.productId);
  }

  void _handleAddToCart() {
    final added = _store.addToCart();
    final productName = _store.product?.name;

    showCartFeedbackSnackBar(
      context,
      title: added ? 'Adicionado ao carrinho' : 'Selecione tamanho e cor',
      subtitle: added ? productName : null,
      isError: !added,
      onViewCart: added ? () => Navigator.pushNamed(context, '/cart') : null,
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
        systemNavigationBarColor: colors.page,
        systemNavigationBarIconBrightness: colors.isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: colors.page,
        body: Column(
          children: [
            OrderHeader(
              title: 'Detalhes',
              colors: colors,
              onBack: () => Navigator.of(context).pop(),
              trailing: Observer(
                builder: (_) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Badge(
                    isLabelVisible: _cartStore.totalItems > 0,
                    label: Text('${_cartStore.totalItems}'),
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: colors.textPrimary,
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/cart'),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: _buildContent()),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Observer(
              builder: (_) => ElevatedButton(
                onPressed: _store.isLoading || _store.product == null
                    ? null
                    : _handleAddToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: GrowColors.primary,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'ADICIONAR AO CARRINHO',
                  style: TextStyle(
                    color: GrowColors.darkTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Observer(
      builder: (_) {
        if (_store.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: GrowColors.primary),
          );
        }

        if (_store.error != null) {
          return Center(
            child: Text(
              _store.error!,
              style: const TextStyle(color: GrowColors.error),
            ),
          );
        }

        final product = _store.product;
        if (product == null) return const SizedBox();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              ProductDetailImageWidget(pathImages: product.galleryUrls),
              const SizedBox(height: 24),
              ProductDetailInfoWidget(name: product.name, price: product.price),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ProductDetailVariantsWidget(store: _store),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _ProductQuantitySelector(store: _store),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ExpandableDescriptionWidget(
                  description: product.description,
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }
}

class _ProductQuantitySelector extends StatelessWidget {
  const _ProductQuantitySelector({required this.store});

  final ProductDetailStore store;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            'Quantidade',
            style: textTheme.bodyMedium?.copyWith(
              color: GrowColors.darkTextSecondary,
              fontWeight: GrowTypography.bold,
            ),
          ),
        ),
        GrowQuantityStepper(
          quantity: store.quantity,
          onDecrement: store.decrementQuantity,
          onIncrement: store.incrementQuantity,
        ),
      ],
    );
  }
}

class ExpandableDescriptionWidget extends StatefulWidget {
  final String description;

  const ExpandableDescriptionWidget({super.key, required this.description});

  @override
  State<ExpandableDescriptionWidget> createState() =>
      _ExpandableDescriptionWidgetState();
}

class _ExpandableDescriptionWidgetState
    extends State<ExpandableDescriptionWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descricao do produto',
          style: textTheme.bodyMedium?.copyWith(
            color: GrowColors.darkTextPrimary,
            fontWeight: GrowTypography.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.description,
          style: textTheme.bodyLarge?.copyWith(
            color: GrowColors.darkTextSecondary,
          ),
          maxLines: isExpanded ? null : 2,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Text(
            isExpanded ? 'Ver menos' : 'Ver mais',
            style: textTheme.bodyMedium?.copyWith(
              color: GrowColors.primary,
              fontWeight: GrowTypography.bold,
            ),
          ),
        ),
      ],
    );
  }
}
