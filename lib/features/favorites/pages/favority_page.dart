import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/cart/utils/cart_currency.dart';
import 'package:growstore/features/cart/widgets/cart/cart_feedback_snackbar.dart';
import 'package:growstore/features/favorites/models/favority_model.dart';
import 'package:growstore/features/favorites/stores/favority/favority_products_store.dart';
import 'package:growstore/features/home/widgets/home_bottom_navigation.dart';
import 'package:growstore/features/orders/widgets/order_header.dart';
import 'package:growstore/features/orders/widgets/order_layout_colors.dart';
import 'package:growstore/shared/widgets/cached_product_image.dart';

class FavorityPage extends StatefulWidget {
  const FavorityPage({super.key});

  @override
  State<FavorityPage> createState() => _FavorityPageState();
}

class _FavorityPageState extends State<FavorityPage> {
  final favorityStore = GetIt.I<FavorityProductsStore>();
  final CartStore _cartStore = GetIt.I.isRegistered<CartStore>()
      ? GetIt.I<CartStore>()
      : CartStore();

  @override
  void initState() {
    super.initState();
    favorityStore.getFavorities();
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
            OrderHeader(title: 'Favoritos', colors: colors),
            Expanded(child: _buildBody(colors)),
          ],
        ),
        bottomNavigationBar: Observer(
          builder: (_) => HomeBottomNavigation(
            selectedLabel: 'Favoritos',
            showCartBadge: false,
            cartItemCount: _cartStore.totalItems,
            onTap: _handleBottomNavigation,
          ),
        ),
      ),
    );
  }

  Widget _buildBody(OrderLayoutColors colors) {
    return Observer(
      builder: (_) {
        if (favorityStore.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: colors.primary),
          );
        }

        if (favorityStore.errorMessage != null) {
          return _FavoritesState(
            colors: colors,
            icon: Icons.wifi_off_rounded,
            title: 'Erro ao carregar favoritos',
            description: favorityStore.errorMessage!,
            onRetry: favorityStore.getFavorities,
          );
        }

        if (favorityStore.favorities.isEmpty) {
          return _FavoritesState(
            colors: colors,
            icon: Icons.favorite_border_rounded,
            title: 'Nenhum favorito ainda',
            description: 'Salve produtos para encontrar tudo por aqui.',
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          itemCount: favorityStore.favorities.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 177 / 279,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final produto = favorityStore.favorities[index];

            return _FavoriteProductCard(
              product: produto,
              colors: colors,
              onOpen: () => Navigator.of(
                context,
              ).pushNamed('/productDetail', arguments: produto.id.toString()),
              onRemoveFavorite: () async {
                await favorityStore.toggleFavority(produto);
              },
              onAddToCart: () => _addToCart(produto),
            );
          },
        );
      },
    );
  }

  void _addToCart(FavorityModel product) {
    _cartStore.addItem(
      CartItemModel(
        id: product.id.toString(),
        name: product.titleProduct,
        variation: '',
        price: product.priceProduct,
        imageUrl: product.pathImage ?? '',
      ),
    );

    showCartFeedbackSnackBar(
      context,
      title: 'Adicionado ao carrinho',
      subtitle: product.titleProduct,
      onViewCart: () => Navigator.of(context).pushNamed('/cart'),
    );
  }
}

class _FavoriteProductCard extends StatelessWidget {
  const _FavoriteProductCard({
    required this.product,
    required this.colors,
    required this.onOpen,
    required this.onRemoveFavorite,
    required this.onAddToCart,
  });

  final FavorityModel product;
  final OrderLayoutColors colors;
  final VoidCallback onOpen;
  final VoidCallback onRemoveFavorite;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final buttonForeground = colors.isDark
        ? const Color(0xFFE2E3DF)
        : const Color(0xFF191C1D);

    return Material(
      color: colors.isDark ? const Color(0xFF3A4859) : colors.card,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: colors.isDark ? const Color(0xFF3A4859) : colors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.cardBorder),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 176,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      GrowCachedProductImage(
                        imageUrl: product.pathImage,
                        backgroundColor: Colors.white,
                        iconColor: colors.primary,
                        fit: BoxFit.contain,
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        cacheWidth: 420,
                        cacheHeight: 420,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          tooltip: 'Remover dos favoritos',
                          onPressed: onRemoveFavorite,
                          icon: Icon(
                            Icons.favorite_rounded,
                            color: colors.primary,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.titleProduct,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.syne(
                            color: colors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            height: 20 / 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          cartCurrency(product.priceProduct),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.syne(
                            color: colors.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            height: 29 / 24,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: 37,
                          child: ElevatedButton.icon(
                            onPressed: onAddToCart,
                            icon: Icon(
                              Icons.shopping_cart_rounded,
                              color: buttonForeground,
                              size: 24,
                            ),
                            label: Text(
                              'adicionar',
                              style: GoogleFonts.syne(
                                color: buttonForeground,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 24 / 20,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: colors.primary,
                              foregroundColor: buttonForeground,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                        ),
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

class _FavoritesState extends StatelessWidget {
  const _FavoritesState({
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
            Icon(icon, color: colors.primary, size: 48),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.textSecondary, fontSize: 14),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 18),
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
