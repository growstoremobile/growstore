import 'package:flutter/material.dart';
import 'package:growstore/features/catalog/models/catalog_model.dart';

class ProductsPage extends StatelessWidget {
  final CatalogModel catalog;

  const ProductsPage({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catalog.title),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 54),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      hint: Text('Buscar produtos...'),
                    ),
                  ),
                ),
                CircleAvatar(child: Icon(Icons.person)),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: catalog.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 177 / 250,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final product = catalog.products[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            width: 177,
                            height: 176,
                            image: NetworkImage(product.imageUrl),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text('R\$ ${product.price}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Início'),
          NavigationDestination(
            icon: Icon(Icons.view_comfy_alt),
            label: 'Categorias',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinho',
          ),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favoritos'),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag),
            label: 'Pedidos',
          ),
        ],
      ),
    );
  }
}
