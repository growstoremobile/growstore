import 'package:flutter/material.dart';

class DefaultProductCard extends StatelessWidget {
  final String titleProduct;
  final IconData? iconButton;
  final IconData? iconFavorite;
  final String? textButton;
  final String? pathImage;
  final double price;
  final VoidCallback? onPressed;

  const DefaultProductCard({
    super.key,
    required this.titleProduct,
    required this.price,
    this.pathImage,
    this.iconButton,
    this.iconFavorite,
    this.textButton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.green, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: pathImage != null
                          ? Image.asset(pathImage!, fit: BoxFit.contain)
                          : const Placeholder(),
                    ),

                    // Favorito
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        iconFavorite ?? iconFavorite,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Informações
            Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.all(.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleProduct,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'R\$ ${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(height: 8),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: onPressed,
                        icon: Icon(iconButton ?? iconButton),
                        label: Text(textButton ?? ''),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                          ),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
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
    );
  }
}
