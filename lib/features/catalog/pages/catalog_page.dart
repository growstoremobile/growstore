import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:growstore/features/catalog/services/catalog_api_service.dart';
import 'package:growstore/features/catalog/stores/catalog_store.dart';
import 'package:growstore/shared/widgets/app_error_dialog.dart';
import 'package:mobx/mobx.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final CatalogStore _store = CatalogStore(
    serviceCatalog: CatalogMockService(),
  );

  late ReactionDisposer _errorDisposer;

  @override
  void initState() {
    super.initState();

    _errorDisposer = reaction<String?>((_) => _store.errorMessage, (message) {
      if (message != null) {
        showAppErrorDialog(context: context, message: message);
        _store.clearError();
      }
    });
    _store.loadCatalog();
  }

  @override
  void dispose() {
    _errorDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Categorias', style: TextTheme.of(context).displayMedium),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),

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
                      prefixIcon: Icon(Icons.search),
                      hint: Text(
                        'Buscar produtos...',
                        style: TextStyle(fontSize: 17),
                      ),
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
          padding: const EdgeInsets.only(
            left: 32,
            top: 24,
            right: 32,
            bottom: 0,
          ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(size: 35, Icons.person),
                                        Text(
                                          catalog.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                        ),
                                        Text(
                                          '${catalog.productQtn} itens',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_comfy_alt, size: 35),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 35),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 35),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, size: 35),
            label: 'Pedidos',
          ),
        ],
        currentIndex: 1,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
