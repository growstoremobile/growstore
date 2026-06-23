import 'package:flutter/material.dart';
import 'package:growstore/features/catalog/widgets/product_detail_image_widget.dart';
import 'package:growstore/features/catalog/widgets/product_detail_info_widget.dart';
import 'package:growstore/features/catalog/widgets/product_detail_variants_widget.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

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
          Badge(
            label: const Text('1'),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {},
            ),
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
              pathImages: [
                'https://ucdecpenkxmuuwpmmbgt.supabase.co/storage/v1/object/public/produto-growstore/tshirt_growdev.png',
              ],
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
