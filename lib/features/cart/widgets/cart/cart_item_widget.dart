import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:growstore/features/cart/models/cart_item_model.dart';
import 'package:growstore/features/cart/utils/cart_currency.dart';
import 'package:growstore/features/cart/widgets/cart/cart_quantity_widget.dart';
import 'package:growstore/features/cart/widgets/cart/cart_styles.dart';
import 'package:growstore/shared/colors/colors.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: cartCardDecoration(),
      child: Row(
        children: [
          // Imagem do produto
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 72,
                height: 72,
                color: AppColors.backgroundColor,
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 72,
                height: 72,
                color: AppColors.backgroundColor,
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.outline,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Nome, variação e controle de quantidade
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                    color: AppColors.deepNavy,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.variation.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    letterSpacing: 0.3,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                CartQuantityWidget(
                  quantity: item.quantity,
                  onIncrement: onIncrement,
                  onDecrement: onDecrement,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Preço da linha (preço unitário x quantidade)
          Text(
            cartCurrency(item.totalPrice),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.growthGreen,
            ),
          ),
        ],
      ),
    );
  }
}
