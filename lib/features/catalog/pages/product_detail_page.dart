import 'package:flutter/material.dart';
import '../widgets/product_detail_image_widget.dart';

// Cores temporárias da GrowStore
// ⚠️ Substitua por AppColors.xxx quando as cores oficiais estiverem prontas
const productBackgroundColor = Color(0xFF0D0D0D); // Preto grafite fundo
const productSurfaceColor = Color(0xFF1A1A1A); // Grafite mais claro (cards)
const productPrimaryGreen = Color(0xFF3DDC6B); // Verde vibrante GrowStore
const productTextPrimary = Color(0xFFFFFFFF); // Branco
const productTextSecondary = Color(0xFF9E9E9E);

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: productBackgroundColor,
      appBar: AppBar(
        backgroundColor: productBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: productTextPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Detalhes",
          style: TextStyle(
            color: productTextPrimary,
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
                  color: productTextPrimary,
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
                    color: productPrimaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "1",
                    style: TextStyle(
                      color: productTextPrimary,
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
              imageUrl: ["assets/images/T-ShirtDark.png"],
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
