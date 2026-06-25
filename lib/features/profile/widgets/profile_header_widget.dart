import 'package:flutter/material.dart';
import 'package:growstore/core/theme/growstore_theme.dart';

/// Cabeçalho da tela de perfil, exibindo o avatar e nome do usuário.
class ProfileHeaderWidget extends StatelessWidget {
  /// Nome do usuário a ser exibido.
  final String userName;

  const ProfileHeaderWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final userInitial = userName.isNotEmpty ? userName[0].toUpperCase() : '?';

    return Container(
      color: GrowColors.primary,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: GrowColors.lightSurface.withAlpha(61),
                  child: Text(
                    userInitial,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: GrowColors.lightSurface.withAlpha(178),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Olá, $userName',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: GrowColors.lightSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: GrowColors.lightSurface,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(13),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: GrowColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'G',
                      style: TextStyle(
                        color: GrowColors.lightSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'GrowStore',
                    style: TextStyle(
                      color: GrowColors.lightTextPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.chevron_right,
                    color: GrowColors.lightTextSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
