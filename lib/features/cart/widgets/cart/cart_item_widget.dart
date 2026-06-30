import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/utils/cart_currency.dart';
import 'package:growstore/features/cart/widgets/cart/cart_styles.dart';
import 'package:growstore/shared/colors/colors.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.item,
    required this.colors,
    required this.onIncrement,
    required this.onDecrement,
  });

  final CartItemModel item;
  final CartLayoutColors colors;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final isNetworkImage =
            item.imageUrl.startsWith('http') ||
            (item.imageUrl.contains('/') &&
                !item.imageUrl.startsWith('assets'));

        return SizedBox(
          height: 115,
          child: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: colors.card,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: colors.cardBorder),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.white,
                    child: isNetworkImage
                        ? CachedNetworkImage(
                            imageUrl: item.imageUrl,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.shopping_bag_outlined,
                              color: AppColors.outline,
                            ),
                          )
                        : Image.asset(
                            item.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.shopping_bag_outlined,
                                  color: AppColors.outline,
                                ),
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 17 / 14,
                          color: colors.textPrimary,
                        ),
                      ),
                      // Pequeno bônus visual: Mostra a variação selecionada abaixo do nome (Ex: Branco / G)
                      if (item.variation != 'Padrão') ...[
                        const SizedBox(height: 4),
                        Text(
                          item.variation,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: colors.textPrimary.withOpacity(0.6),
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        cartCurrency(item.totalPrice),
                        maxLines: 1,
                        style: GoogleFonts.syne(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 29 / 24,
                          color: colors.primary,
                          letterSpacing: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 78,
                  child: _CartItemControls(
                    colors: colors,
                    selectedSize: _selectedSize(item.variation),
                    quantity: item.quantity,
                    onIncrement: onIncrement,
                    onDecrement: onDecrement,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _selectedSize(String variation) {
    if (!variation.contains('/')) return 'G';
    final normalized = variation.split('/').last.trim().toUpperCase();

    if (normalized == 'P' ||
        normalized == 'M' ||
        normalized == 'G' ||
        normalized == 'GG' ||
        normalized == 'XG') {
      return normalized;
    }

    return 'G';
  }
}

class _CartItemControls extends StatelessWidget {
  const _CartItemControls({
    required this.colors,
    required this.selectedSize,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final CartLayoutColors colors;
  final String selectedSize;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            for (final size in ['P', 'M', 'G']) ...[
              if (size != 'P') const SizedBox(width: 4),
              _CartSizeChip(
                label: size,
                selected: size == selectedSize,
                colors: colors,
              ),
            ],
          ],
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _CartQuantityButton(
              icon: Icons.remove,
              colors: colors,
              onPressed: onDecrement,
            ),
            SizedBox(
              width: 26,
              child: Text(
                '$quantity',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 20 / 16,
                  color: colors.textPrimary,
                ),
              ),
            ),
            _CartQuantityButton(
              icon: Icons.add,
              colors: colors,
              onPressed: onIncrement,
            ),
          ],
        ),
      ],
    );
  }
}

class _CartSizeChip extends StatelessWidget {
  const _CartSizeChip({
    required this.label,
    required this.selected,
    required this.colors,
  });

  final String label;
  final bool selected;
  final CartLayoutColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23,
      height: 23,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? colors.sizeChipSelected : colors.sizeChip,
        borderRadius: BorderRadius.circular(8),
        border: selected ? Border.all(color: colors.primary) : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 15 / 12,
          color: selected ? colors.sizeChipSelectedText : colors.sizeChipText,
        ),
      ),
    );
  }
}

class _CartQuantityButton extends StatelessWidget {
  const _CartQuantityButton({
    required this.icon,
    required this.colors,
    required this.onPressed,
  });

  final IconData icon;
  final CartLayoutColors colors;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.quantityButton,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: SizedBox(
          width: 23,
          height: 23,
          child: Icon(icon, size: 15, color: colors.primary),
        ),
      ),
    );
  }
}
