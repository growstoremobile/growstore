import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
        title: const TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'Buscar produtos...',
          ),
        ),
        actions: const [CircleAvatar(child: Icon(Icons.person))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Categorias', textAlign: TextAlign.center),
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

                      return Card(
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
                              Text(catalog.title, textAlign: TextAlign.center),
                              Text(
                                '${catalog.products.length} itens',
                                textAlign: TextAlign.center,
                              ),
                            ],
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
