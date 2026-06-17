import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:growstore/features/catalog/stores/catalog_store.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final CatalogStore _store = CatalogStore();

  @override
  void initState() {
    super.initState();
    _store.loadCatalog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 54),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      hint: Text('Buscar produtos...'),
                    ),
                    onChanged: _store.setSearch,
                  ),
                ),
                const CircleAvatar(child: Icon(Icons.person)),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: Observer(
                  builder: (context) {
                    final filteredList = _store.filteredCatalogs;
                    return _store.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            itemCount: filteredList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 19,
                                ),
                            itemBuilder: (BuildContext context, int index) {
                              final catalog = filteredList[index];

                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.person),
                                        Text(
                                          catalog.title,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          '${catalog.productQtn} itens',
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
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
