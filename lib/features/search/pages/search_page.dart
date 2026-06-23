import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/search/widgets/search_layout_colors.dart';
import 'package:growstore/features/search/widgets/search_product_card.dart';
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
        _errorMessage = 'Não foi possível carregar os produtos.';
        _isLoading = false;
      });
    }
  }

  void _filterProducts() {
    final query = _controller.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _products;
        return;
      }

      _filteredProducts = _products.where((product) {
        final title = (product['title'] ?? '').toString().toLowerCase();
        final category = (product['category'] ?? '').toString().toLowerCase();
        final description = (product['description'] ?? '')
            .toString()
            .toLowerCase();

        return title.contains(query) ||
            category.contains(query) ||
            description.contains(query);
      }).toList();
    });
  }

  void _showDetailsSoon(Map<String, dynamic> product) {
    final title = (product['title'] ?? 'Produto').toString();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$title em breve.')));
  }

  @override
  Widget build(BuildContext context) {
    final colors = SearchLayoutColors.resolve(
      Theme.of(context).brightness == Brightness.dark,
    );

    return Scaffold(
      backgroundColor: colors.page,
      body: SafeArea(
        child: Column(
          children: [
            _SearchHeader(
              controller: _controller,
              colors: colors,
              onBack: () => Navigator.of(context).pop(),
              onClear: _controller.clear,
            ),
            Expanded(child: _buildContent(colors)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(SearchLayoutColors colors) {
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
            'Tente buscar por camiseta, mochila, caneca ou acessórios.',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      itemCount: _filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .58,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];

        return SearchProductCard(
          product: product,
          colors: colors,
          onTap: () => _showDetailsSoon(product),
        );
      },
    );
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader({
    required this.controller,
    required this.colors,
    required this.onBack,
    required this.onClear,
  });

  final TextEditingController controller;
  final SearchLayoutColors colors;
  final VoidCallback onBack;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 20, 16),
      decoration: BoxDecoration(
        color: colors.header,
        border: Border(bottom: BorderSide(color: colors.headerBorder)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back_rounded, color: colors.primary),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: true,
              cursorColor: colors.primary,
              style: GoogleFonts.inter(
                color: colors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Buscar produtos',
                hintStyle: GoogleFonts.inter(
                  color: colors.textSecondary,
                  fontSize: 16,
                ),
                prefixIcon: Icon(Icons.search_rounded, color: colors.primary),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller,
                  builder: (_, value, _) {
                    if (value.text.isEmpty) return const SizedBox.shrink();

                    return IconButton(
                      onPressed: onClear,
                      icon: Icon(Icons.close_rounded, color: colors.primary),
                    );
                  },
                ),
                filled: true,
                fillColor: colors.field,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: colors.fieldBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: colors.primary),
                ),
              ),
            ),
          ),
        ],
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

  final SearchLayoutColors colors;
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
                color: colors.textPrimary,
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
                color: colors.textSecondary,
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
                  foregroundColor: colors.buttonForeground,
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
