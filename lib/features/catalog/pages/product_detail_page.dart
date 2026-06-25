import 'package:flutter/material.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/catalog/widgets/product_detail_image_widget.dart';
import 'package:growstore/features/catalog/widgets/product_detail_info_widget.dart';
import 'package:growstore/features/catalog/widgets/product_detail_variants_widget.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GrowColors.darkBg, // Fundo ultra dark oficial
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // 1. Imagem do Produto
            const ProductDetailImageWidget(
              pathImages: [
                'https://ucdecpenkxmuuwpmmbgt.supabase.co/storage/v1/object/public/produto-growstore/tshirt_growdev.png',
              ],
            ),
            const SizedBox(height: 24),

            // 2. Informações Principais (Nome e Preço - já com o limitador interno)
            const ProductDetailInfoWidget(
              name: 'Nome do produto com múltiplas linhas',
              price: 199.90,
            ),
            const SizedBox(height: 24),

            // 3. Variantes (Cores com texto abaixo e Tamanhos P, M, G, GG centralizados)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ProductDetailVariantsWidget(),
            ),
            const SizedBox(height: 24),

            // 4. Descrição do Produto com o efeito "Ver mais"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ExpandableDescriptionWidget(
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                    'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                    'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
                    'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
              ),
            ),
            const SizedBox(height: 32), // Espaço de segurança para o scroll
          ],
        ),
      ),

      // 5. Botão "Adicionar ao Carrinho" Fixo no Rodapé (Não rola com o scroll)
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Ação de adicionar ao carrinho
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: GrowColors.primary, // Verde oficial da paleta
              minimumSize: const Size.fromHeight(
                50,
              ), // Botão alto igual ao protótipo
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
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isExpanded ? 'Ver menos ̂' : 'Ver mais ˅',
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
