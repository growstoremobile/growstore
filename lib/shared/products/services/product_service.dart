import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

class ProductService {
  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      debugPrint('[ProductService] iniciando fetchAllProducts()');
      final response = await Supabase.instance.client
          .from('produtos')
          .select('*,categorias(id_category,name_category),product_details(*)');

      try {
        final list = List<Map<String, dynamic>>.from(response);
        debugPrint('[ProductService] produtos retornados: ${list.length}');
        if (list.isNotEmpty) {
          debugPrint(
            '[ProductService] amostra primeira product keys: ${list.first.keys.toList()}',
          );
          final detalhes = _firstProductDetail(list.first['product_details']);
          debugPrint(
            '[ProductService] primeira product_details keys: ${detalhes?.keys.toList()}',
          );
        }
        return list.map((product) => _normalizeProduct(product)).toList();
      } catch (e, s) {
        debugPrint(
          '[ProductService] erro ao converter response para lista: $e',
        );
        debugPrint('$s');
        rethrow;
      }
    } catch (e, s) {
      debugPrint('[ProductService] excecao ao buscar produtos: $e');
      debugPrint('$s');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchCategoriesWithQuantity() async {
    try {
      final responseCategorias = await Supabase.instance.client
          .from('view_categorias')
          .select();

      final listaCategorias = List<Map<String, dynamic>>.from(
        responseCategorias,
      );
      final listaProdutos = await fetchAllProducts();

      for (final categoria in listaCategorias) {
        final idCategoriaAtual = categoria['id_category'];
        final produtosDaCategoria = listaProdutos.where(
          (produto) =>
              produto['id_categoria']?.toString() ==
              idCategoriaAtual?.toString(),
        );

        final imagensDaCategoria = produtosDaCategoria
            .map((produto) {
              final detalhes = _firstProductDetail(produto['product_details']);
              final detailImage = detalhes?['main_image'];
              return (detailImage ?? produto['image'] ?? '').toString();
            })
            .where((url) => url.isNotEmpty)
            .toList();

        categoria['category_images'] = imagensDaCategoria;
      }

      return listaCategorias;
    } catch (_) {
      rethrow;
    }
  }

  Map<String, dynamic> _normalizeProduct(Map<String, dynamic> product) {
    final rawCategory = product['categorias'];
    final category = rawCategory is Map
        ? rawCategory['name_category']
        : product['category'] ?? product['categoria'];
    final categoryName = category?.toString().trim();
    final title = product['title'] ?? product['title_product'];
    final detail = _firstProductDetail(product['product_details']);

    // tenta encontrar imagens em várias chaves possíveis (compatibilidade)
    String? image =
        product['image'] ?? product['imageUrl'] ?? product['path_image'];

    if ((image == null || image.toString().isEmpty) && detail != null) {
      image =
          detail['main_image'] ?? detail['mainImage'] ?? detail['path_image'];
    }
    final detailPrice = detail?['price'] ?? detail?['price_product'];
    final price =
        product['price'] ?? product['price_product'] ?? detailPrice ?? 0;

    return {
      ...product,
      'title': title?.toString().trim().isNotEmpty == true ? title : 'Produto',
      'image': image ?? '',
      'price': price,
      'category': categoryName == null || categoryName.isEmpty
          ? 'Produto'
          : categoryName,
    };
  }

  Map<String, dynamic>? _firstProductDetail(Object? details) {
    if (details == null) return null;

    // Se o banco retornar o detalhe como String (JSON em formato de texto), fazemos o decode!
    if (details is String && details.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(details);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
        if (decoded is List && decoded.isNotEmpty && decoded.first is Map) {
          return Map<String, dynamic>.from(decoded.first as Map);
        }
      } catch (e) {
        debugPrint(
          '[ProductService] Erro ao decodificar String de details: $e',
        );
      }
    }

    if (details is Map) {
      return Map<String, dynamic>.from(details);
    }

    if (details is List && details.isNotEmpty && details.first is Map) {
      return Map<String, dynamic>.from(details.first as Map);
    }

    return null;
  }
}
