import 'package:flutter/material.dart';
import 'package:growstore/features/catalog/widgets/product_detail_image_widget.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/catalog/widgets/product_detail_info_widget.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GrowColors.darkBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: GrowColors.darkTextPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Detalhes",
          style: TextStyle(
            color: GrowColors.darkTextPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: GrowColors.darkTextPrimary,
                ),
                onPressed: () {
                  // Navegar para a página do carrinho
                },
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: GrowColors.darkBg,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "1",
                    style: TextStyle(
                      color: GrowColors.darkTextPrimary,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),

            ProductDetailImageWidget(
              pathImages: ["assets/images/tshirt_growdev.png"],
            ),

            SizedBox(height: 24),

            ProductDetailInfoWidget(
              name: 'Nome do produto com múltiplas linhas',
              price: 199.90,
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                  'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                  'nisi ut aliquip ex ea commodo consequat.',
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
