import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/theme/widgets/error_state_widget.dart';
import 'package:growstore/features/categories/pages/detail_categories_page.dart';
import 'package:growstore/features/categories/stores/categories_store.dart';

import 'package:growstore/features/categories/widgets/category_search_bar.dart';
import 'package:growstore/features/home/widgets/home_layout_colors.dart';
import 'package:growstore/shared/widgets/cached_product_image.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoryStore _store = GetIt.I<CategoryStore>();

  @override
  void initState() {
    super.initState();
    _store.loadCategories();
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
            CategorySearchBar(
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
                    final filteredList = _store.filteredCategories;
                    if (_store.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (_store.errorMessage != null) {
                      return GrowErrorState(
                        type: GrowErrorType.custom,
                        title: 'Erro ao carregar categorias',
                        description: 'Não foi possível carregar as categorias.',
                        onRetry: _store.loadCategories,
                      );
                    }

                    return GridView.builder(
                      itemCount: filteredList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.8,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 19,
                          ),
                      itemBuilder: (BuildContext context, int index) {
                        final category = filteredList[index];

                        return InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  DetailCategoriesPage(category: category),
                            ),
                          ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 44,
                                    child: GrowCachedProductImage(
                                      imageUrl: category.imageUrl,
                                      backgroundColor: Colors.transparent,
                                      iconColor: colors.primary,
                                    ),
                                  ),
                                  Text(
                                    category.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 14),
                                  ),
                                  Text(
                                    '${category.productQtn} produtos',
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
    );
  }
}
