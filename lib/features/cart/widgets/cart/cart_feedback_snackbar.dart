import 'package:flutter/material.dart';
import 'package:growstore/core/theme/growstore_theme.dart';

void showCartFeedbackSnackBar(
  BuildContext context, {
  required String title,
  String? subtitle,
  VoidCallback? onViewCart,
  bool isError = false,
}) {
  final messenger = ScaffoldMessenger.of(context);

  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: isError ? 2200 : 1500),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      content: _CartFeedbackContent(
        title: title,
        subtitle: subtitle,
        isError: isError,
        onViewCart: onViewCart == null
            ? null
            : () {
                messenger.hideCurrentSnackBar();
                onViewCart();
              },
      ),
    ),
  );
}

class _CartFeedbackContent extends StatelessWidget {
  const _CartFeedbackContent({
    required this.title,
    required this.subtitle,
    required this.isError,
    required this.onViewCart,
  });

  final String title;
  final String? subtitle;
  final bool isError;
  final VoidCallback? onViewCart;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isError ? GrowColors.error : GrowColors.primary;
    final surface = isDark ? const Color(0xFF101B29) : Colors.white;
    final textPrimary = isDark
        ? GrowColors.darkTextPrimary
        : GrowColors.lightTextPrimary;
    final textSecondary = isDark
        ? const Color(0xFFB8C0C8)
        : GrowColors.lightTextSecondary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.34)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.32 : 0.14),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isError ? Icons.error_outline_rounded : Icons.check_rounded,
                color: accent,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (onViewCart != null) ...[
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: onViewCart,
                icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                label: const Text('Ver'),
                style: TextButton.styleFrom(
                  foregroundColor: accent,
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 34),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
