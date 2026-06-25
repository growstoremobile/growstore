import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/catalog/stores/product_detail_store.dart';
import 'package:growstore/features/catalog/widgets/product_detail_image_widget.dart';
import 'package:growstore/features/catalog/widgets/product_detail_info_widget.dart';
import 'package:growstore/features/catalog/widgets/product_detail_variants_widget.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late final ProductDetailStore _store;

  @override
  void initState() {
    super.initState();
    _store = GetIt.I.get<ProductDetailStore>();
    _store.loadProduct(widget.productId);
  }

  void _handleAddToCart() {
    final added = _store.addToCart();
    if (added) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Produto adicionado ao carrinho!'),
          backgroundColor: GrowColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          action: SnackBarAction(
            label: 'Ver carrinho',
            textColor: GrowColors.darkBg,
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Selecione tamanho e cor antes de adicionar!'),
          backgroundColor: GrowColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Detalhes'),
        centerTitle: true,
        actions: [
          Observer(
            builder: (_) {
              final cartStore = GetIt.I.get<CartStore>();
              return Badge(
                label: Text('${cartStore.totalItems}'),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => Navigator.pushNamed(context, '/cart'),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Observer(
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

                ProductDetailInfoWidget(
                  name: product.name,
                  price: product.price,
                ),
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ProductDetailVariantsWidget(store: _store),
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
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _handleAddToCart,
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
          'Descrição do produto',
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isExpanded ? 'Ver menos ˄' : 'Ver mais ˅',
                style: textTheme.bodyMedium?.copyWith(
                  color: GrowColors.primary,
                  fontWeight: GrowTypography.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
