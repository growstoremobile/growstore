import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/catalog/models/product_detail_model.dart';
import 'package:growstore/features/catalog/repositories/product_detail_repository.dart';
import 'package:mobx/mobx.dart';

part 'product_detail_store.g.dart';

class ProductDetailStore = ProductDetailStoreBase with _$ProductDetailStore;

abstract class ProductDetailStoreBase with Store {
  final ProductDetailRepository _repository;
  final CartStore _cartStore;

  ProductDetailStoreBase({
    required ProductDetailRepository repository,
    required CartStore cartStore,
  }) : _repository = repository,
       _cartStore = cartStore;

  @observable
  ProductDetailsModel? product;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  String? selectedSize;

  // selectedColor armazena o HEX da cor selecionada (ex: '#FFFFFF', '#0A0A0A')
  @observable
  String? selectedColor;

  @observable
  int quantity = 1;

  @action
  Future<void> loadProduct(String productId) async {
    try {
      isLoading = true;
      error = null;
      selectedSize = null;
      selectedColor = null;
      quantity = 1;
      product = await _repository.getProductById(productId);
    } catch (e) {
      error = 'Erro ao carregar o produto: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  void selectSize(String size) => selectedSize = size;

  @action
  void selectColor(String colorHex) => selectedColor = colorHex;

  @action
  void incrementQuantity() => quantity++;

  @action
  void decrementQuantity() {
    if (quantity <= 1) return;
    quantity--;
  }

  // Converte o hex selecionado para o nome de cor que o model usa internamente
  String get selectedColorName {
    if (selectedColor == null) return 'Padrão';
    final hex = selectedColor!.toUpperCase().replaceAll('#', '');
    if (hex == '0A0A0A' || hex == '000000') return 'Preto';
    if (hex == 'FFFFFF') return 'Branco';
    return 'Padrão';
  }

  // Retorna a imagem atual baseada na cor selecionada
  // Usado pela PDP para atualizar a galeria em tempo real
  List<String> get currentGallery {
    final p = product;
    if (p == null) return [];
    if (selectedColor == null) return p.galleryUrls;
    return p.getGalleryForColor(selectedColorName);
  }

  // Verifica se o produto tem opção de cor
  bool get hasColorOptions {
    final currentProduct = product;
    if (currentProduct == null) return false;
    // Tem opções de cor se tiver mais de uma imagem na galeria
    if (currentProduct.colorVariations.length >= 2) return true;
    // Ou se for camiseta/tshirt ou caneca gold line pelo nome
    final name = currentProduct.name.toLowerCase();
    return name.contains('camiseta') ||
        name.contains('tshirt') ||
        (name.contains('caneca') && name.contains('gold line'));
  }

  bool get hasValidSelection {
    final currentProduct = product;
    if (currentProduct == null) return false;

    final sizeOk =
        !currentProduct.hasSizeOptions ||
        (selectedSize != null && selectedSize!.trim().isNotEmpty);

    final colorOk =
        !hasColorOptions ||
        (selectedColor != null && selectedColor!.trim().isNotEmpty);

    return sizeOk && colorOk;
  }

  @action
  bool addToCart() {
    final currentProduct = product;
    if (currentProduct == null || !hasValidSelection) return false;

    final colorName = selectedColorName;
    final size = selectedSize?.trim();
    final needsSize = currentProduct.hasSizeOptions;
    final needsColor = hasColorOptions;

    // Monta a string de variação legível para exibir no carrinho
    String variation = 'Padrão';
    if (needsColor && needsSize && size != null) {
      variation = '$colorName / $size';
    } else if (needsColor) {
      variation = colorName;
    } else if (needsSize && size != null) {
      variation = size;
    }

    // Busca a imagem correta para a cor selecionada
    String imageUrl = currentProduct.mainImageUrl;
    if (needsColor && selectedColor != null) {
      imageUrl = currentProduct.getImageForColor(colorName);
    }

    // ID único por produto + cor + tamanho para separar variações no carrinho
    final uniqueId = needsColor || needsSize
        ? '${currentProduct.uid}_${colorName}_${size ?? ""}'
        : currentProduct.uid;

    _cartStore.addItem(
      CartItemModel(
        id: uniqueId,
        name: currentProduct.name,
        variation: variation,
        price: currentProduct.price,
        imageUrl: imageUrl,
        quantity: quantity,
      ),
    );

    return true;
  }
}
