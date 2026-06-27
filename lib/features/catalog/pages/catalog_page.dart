import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:growstore/features/catalog/services/catalog_api_service.dart';
import 'package:growstore/features/catalog/stores/catalog_store.dart';
import 'package:growstore/features/catalog/widgets/catalog_bottom_navigation.dart';
import 'package:growstore/features/catalog/widgets/catalog_search_bar.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';
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

  void _handleBottomNavigation(String label) {
    switch (label) {
      case 'Inicio':
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
        break;
      case 'Categorias':
        break;
      case 'Carrinho':
        Navigator.of(context).pushNamed('/cart');
        break;
      case 'Favoritos':
        Navigator.of(context).pushNamed('/favorites');
        break;
      case 'Pedidos':
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Pedidos em breve.')));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = HomeLayoutColors.resolve(isDark);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CatalogSearchBar(
              colors: colors,
              isDark: isDark,
              onSearchChanged: _store.setSearch,
              onProfile: () => Navigator.of(context).pushNamed('/profile'),
            ),
            Divider(height: 1, thickness: 1, color: colors.divider),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 32, top: 24, right: 32),
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
                                onTap: () =>
                                    Navigator.of(context).pushNamed('/search'),
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: CatalogBottomNavigation(
        onTap: _handleBottomNavigation,
      ),
    );
  }
}
