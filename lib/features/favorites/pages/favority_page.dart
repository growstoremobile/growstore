import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/favorites/stores/favority/favority_products_store.dart';
import 'package:growstore/shared/widgets/default_product_card_widget.dart';

class FavorityPage extends StatefulWidget {
  const FavorityPage({super.key});

  @override
  State<FavorityPage> createState() => _FavorityPageState();
}

class _FavorityPageState extends State<FavorityPage> {
  final favorityStore = GetIt.I<FavorityProductsStore>();

  @override
  void initState() {
    super.initState();
    favorityStore.getFavorities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos'), centerTitle: true),
      body: Observer(
        builder: (_) {
          if (favorityStore.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }

          if (favorityStore.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    favorityStore.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: favorityStore.getFavorities,
                    child: const Text("Tentar novamente"),
                  ),
                ],
              ),
            );
          }

          if (favorityStore.favorities.isEmpty) {
            return const Center(
              child: Text(
                'Você ainda não tem produtos favoritos.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: GridView.builder(
              itemCount: favorityStore.favorities.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.58,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final produto = favorityStore.favorities[index];
                return DefaultProductCard(
                  titleProduct: produto.titleProduct,
                  iconFavority: favorityStore.isFavorite(produto.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  price: (produto.priceProduct as num).toDouble(),
                  pathImage: produto.pathImage,
                  iconButton: Icons.shopping_cart,
                  textButton: 'Adicionar',
                  onPressed: () {
                    favorityStore.toggleFavority(produto);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
