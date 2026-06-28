import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/categories/widgets/category_header.dart';
import 'package:growstore/features/categories/widgets/category_layout_colors.dart';
import 'package:growstore/features/categories/widgets/category_product_card.dart';
import 'package:growstore/shared/products/services/product_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  final _productService = ProductService();

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _filteredProducts = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _selectedCategory = 'Todas';

  List<String> get _categories {
    final values =
        _products
            .map((product) => (product['category'] ?? '').toString().trim())
            .where((category) => category.isNotEmpty)
            .toSet()
            .toList()
          ..sort();

    return ['Todas', ...values];
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_filterProducts);
    _loadProducts();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_filterProducts)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _productService.fetchAllProducts();

      if (!mounted) return;

      setState(() {
        _products = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage = 'Nao foi possivel carregar os produtos.';
        _isLoading = false;
      });
    }
  }

  void _filterProducts() {
    final query = _controller.text.trim().toLowerCase();

    setState(() {
      _filteredProducts = _products.where((product) {
        final title = (product['title'] ?? '').toString().toLowerCase();
        final category = (product['category'] ?? '').toString().toLowerCase();
        final description = (product['description'] ?? '')
            .toString()
            .toLowerCase();
        final matchesCategory =
            _selectedCategory == 'Todas' ||
            category == _selectedCategory.toLowerCase();
        final matchesQuery =
            query.isEmpty ||
            title.contains(query) ||
            category.contains(query) ||
            description.contains(query);

        return matchesCategory && matchesQuery;
      }).toList();
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _filterProducts();
  }

  @override
  Widget build(BuildContext context) {
    final colors = CategoryLayoutColors.resolve(
      Theme.of(context).brightness == Brightness.dark,
    );

    return Scaffold(
      backgroundColor: colors.page,
      body: Column(
        children: [
          CategoryHeader(
            title: 'Buscar',
            colors: colors,
            controller: _controller,
            onBack: () => Navigator.of(context).pop(),
            onClear: _controller.clear,
            onProfile: () => Navigator.of(context).pushNamed('/profile'),
          ),
          if (!_isLoading && _errorMessage == null)
            _SearchCategoryFilters(
              categories: _categories,
              selectedCategory: _selectedCategory,
              colors: colors,
              onSelected: _selectCategory,
            ),
          Expanded(child: _buildContent(colors)),
        ],
      ),
    );
  }

  Widget _buildContent(CategoryLayoutColors colors) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(color: colors.primary));
    }

    if (_errorMessage != null) {
      return _SearchStateMessage(
        colors: colors,
        icon: Icons.wifi_off_rounded,
        title: 'Erro na busca',
        description: _errorMessage!,
        actionLabel: 'TENTAR NOVAMENTE',
        onAction: () {
          setState(() {
            _isLoading = true;
            _errorMessage = null;
          });
          _loadProducts();
        },
      );
    }

    if (_filteredProducts.isEmpty) {
      return _SearchStateMessage(
        colors: colors,
        icon: Icons.search_off_rounded,
        title: 'Nenhum produto encontrado',
        description:
            'Tente buscar por camiseta, mochila, caneca ou acessorios.',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      cacheExtent: 360,
      itemCount: _filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 177 / 250,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];

        return CategoryProductCard(
          product: product,
          colors: colors,
          onTap: () => Navigator.of(
            context,
          ).pushNamed('/productDetail', arguments: product['id'].toString()),
        );
      },
    );
  }
}

class _SearchCategoryFilters extends StatelessWidget {
  const _SearchCategoryFilters({
    required this.categories,
    required this.selectedCategory,
    required this.colors,
    required this.onSelected,
  });

  final List<String> categories;
  final String selectedCategory;
  final CategoryLayoutColors colors;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = category == selectedCategory;

          return ChoiceChip(
            selected: selected,
            label: Text(category),
            showCheckmark: false,
            onSelected: (_) => onSelected(category),
            labelStyle: GoogleFonts.inter(
              color: selected ? Colors.white : colors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: colors.page,
            selectedColor: colors.primary,
            side: BorderSide(
              color: selected ? colors.primary : colors.categoryBorder,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          );
        },
      ),
    );
  }
}

class _SearchStateMessage extends StatelessWidget {
  const _SearchStateMessage({
    required this.colors,
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

  final CategoryLayoutColors colors;
  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: colors.primary, size: 44),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.syne(
                color: colors.categoryText,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 32 / 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: colors.categoryMeta,
                fontSize: 15,
                height: 22 / 15,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 20),
              FilledButton(
                onPressed: onAction,
                style: FilledButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                ),
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
