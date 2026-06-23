import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/home/models/home_product_model.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';

class HomeProductGrid extends StatelessWidget {
  const HomeProductGrid({
    super.key,
    required this.products,
    required this.colors,
    required this.onTap,
  });

  final List<HomeProductModel> products;
  final HomeLayoutColors colors;
  final ValueChanged<HomeProductModel> onTap;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Container(
        color: colors.productGrid,
        constraints: const BoxConstraints(minHeight: 250),
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 64),
        alignment: Alignment.center,
        child: Text(
          'Nenhum produto nesta categoria',
          textAlign: TextAlign.center,
          style: GoogleFonts.syne(
            color: colors.productName,
            fontSize: 16,
            height: 22 / 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Container(
      color: colors.productGrid,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 12,
          childAspectRatio: 177 / 250,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return _HomeProductCard(
            product: product,
            colors: colors,
            onTap: () => onTap(product),
          );
        },
      ),
    );
  }
}

class _HomeProductCard extends StatelessWidget {
  const _HomeProductCard({
    required this.product,
    required this.colors,
    required this.onTap,
  });

  final HomeProductModel product;
  final HomeLayoutColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.productCard,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: colors.productCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.productBorder),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 161 / 160,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(product.asset, fit: BoxFit.cover),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: SizedBox.square(
                          dimension: 38,
                          child: IconButton(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.favorite_border_rounded,
                              color: colors.primary,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.syne(
                            color: colors.productName,
                            fontSize: 15,
                            height: 20 / 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          product.price,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.syne(
                            color: colors.primary,
                            fontSize: 24,
                            height: 22 / 24,
                            fontWeight: FontWeight.w600,
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
