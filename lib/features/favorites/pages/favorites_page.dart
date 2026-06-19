import 'package:flutter/material.dart';
import 'package:growstore/shared/widgets/default_product_card_widget.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});
  final List<Map<String, dynamic>> store = [
    {
      'name': 'Camiseta',
      'price': 29.90,
      'image': 'assets/images/tshirt_growdev.png',
    },
    {
      'name': 'Camiseta',
      'price': 29.90,
      'image': 'assets/images/tshirt_growdev.png',
    },
    {
      'name': 'Camiseta',
      'price': 29.99,
      'image': 'assets/images/tshirt_growdev.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: GridView.builder(
          itemCount: store.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.58,
          ),
          itemBuilder: (context, index) {
            return DefaultProductCard(
              titleProduct: store[index]['name'],
              iconFavorite: Icons.favorite,
              price: store[index]['price'],
              pathImage: store[index]['image'],
              iconButton: Icons.shopping_cart,
              textButton: 'Adicionar',
              onPressed: () {},
            );
          },
        ),
      ),
    );
  }
}
