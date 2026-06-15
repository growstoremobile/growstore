import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:growstore/features/catalog/pages/products_page.dart';
import 'package:growstore/features/catalog/stores/catalog_store.dart';

class CatalogPage extends StatelessWidget {
  final CatalogStore _store = CatalogStore();
  CatalogPage({super.key}) {
    _store.loadCatalog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Observer(
              builder: (context) {
                return Expanded(
                  child: GridView.builder(
                    itemCount: _store.catalogs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 19,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      final catalog = _store.catalogs[index];

                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductsPage(catalog: catalog),
                          ),
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image(
                                    image: NetworkImage(
                                      catalog.products[index].imageUrl,
                                    ),
                                  ),
                                ),
                                Text(
                                  catalog.title,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${catalog.products.length} itens',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
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
