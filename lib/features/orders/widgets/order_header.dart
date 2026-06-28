import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/features/orders/widgets/order_layout_colors.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({
    super.key,
    required this.title,
    required this.colors,
    this.onBack,
    this.trailing,
  });

  final String title;
  final OrderLayoutColors colors;
  final VoidCallback? onBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Container(
      width: double.infinity,
      height: topInset + 54,
      decoration: BoxDecoration(
        color: colors.header,
        border: Border(bottom: BorderSide(color: colors.divider)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: topInset),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (onBack != null)
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: onBack,
                  icon: Icon(
                    Icons.chevron_left_rounded,
                    color: colors.textPrimary,
                    size: 32,
                  ),
                ),
              ),
            if (trailing != null) Positioned(right: 0, child: trailing!),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 68),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.syne(
                  color: colors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 29 / 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
