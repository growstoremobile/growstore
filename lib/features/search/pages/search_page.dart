import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/search/widgets/search_product_card.dart';
import 'package:growstore/shared/products/services/product_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const _green = Color(0xFF39FF14);
  static const _page = Color(0xFF04090F);

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
    return Scaffold(
      backgroundColor: _page,
      body: SafeArea(
        child: Column(
          children: [
            _SearchHeader(
              controller: _controller,
              onBack: () => Navigator.of(context).pop(),
              onClear: _controller.clear,
            ),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: _green));
    }

    if (_errorMessage != null) {
      return _SearchStateMessage(
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
      return const _SearchStateMessage(
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
          onTap: () => _showDetailsSoon(product),
        );
      },
    );
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader({
    required this.controller,
    required this.onBack,
    required this.onClear,
  });

  final TextEditingController controller;
  final VoidCallback onBack;
  final VoidCallback onClear;

  static const _green = Color(0xFF39FF14);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 20, 16),
      decoration: BoxDecoration(
        color: const Color(0xFF111412).withValues(alpha: .72),
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: .10)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_rounded, color: _green),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: true,
              cursorColor: _green,
              style: GoogleFonts.inter(
                color: const Color(0xFFE2E3DF),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Buscar produtos',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFFBACCB0),
                  fontSize: 16,
                ),
                prefixIcon: const Icon(Icons.search_rounded, color: _green),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller,
                  builder: (_, value, _) {
                    if (value.text.isEmpty) return const SizedBox.shrink();

                    return IconButton(
                      onPressed: onClear,
                      icon: const Icon(Icons.close_rounded, color: _green),
                    );
                  },
                ),
                filled: true,
                fillColor: const Color(0xFF04090F),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: .10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: _green),
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
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

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
            Icon(icon, color: const Color(0xFF39FF14), size: 44),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.syne(
                color: const Color(0xFFE2E3DF),
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
                color: const Color(0xFFBACCB0),
                fontSize: 15,
                height: 22 / 15,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 20),
              FilledButton(
                onPressed: onAction,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF39FF14),
                  foregroundColor: const Color(0xFF04090F),
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
