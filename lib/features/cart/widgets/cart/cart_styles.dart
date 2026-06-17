import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

// Estilo de card da tela de carrinho: fundo cinza claro + borda verde, como no
// Figma. Definido localmente na feature para não alterar a paleta global
// compartilhada (responsabilidade da tarefa de tema).
const Color cartCardColor = Color(0xFFEAEEEA);

BoxDecoration cartCardDecoration() {
  return BoxDecoration(
    color: cartCardColor,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: AppColors.growthGreen.withValues(alpha: 0.6),
      width: 1.5,
    ),
  );
}
