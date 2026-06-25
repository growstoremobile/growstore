import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:growstore/features/auth/stores/register/register_store.dart';
import 'package:growstore/features/auth/widgets/register/register_text_field_widget.dart';

class RegisterFormFieldsWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final RegisterStore store;

  const RegisterFormFieldsWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        children: [
          RegisterTextFieldWidget(
            controller: nameController,
            label: 'Nome completo',
            hint: 'Como deseja ser chamado?',
            prefixIcon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            autofillHints: const [AutofillHints.name],
          ),
          const SizedBox(height: 10),
          RegisterTextFieldWidget(
            controller: emailController,
            label: 'E-mail',
            hint: 'seu@email.com',
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
          ),
          const SizedBox(height: 10),
          Observer(
            builder: (_) {
              return RegisterTextFieldWidget(
                controller: passwordController,
                label: 'Senha',
                hint: 'Mínimo de 8 caracteres',
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                obscureText: store.obscurePassword,
                onToggleVisibility: store.togglePasswordVisibility,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (value.length < 8) {
                    return 'A senha deve ter no mínimo 8 caracteres';
                  }
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 10),
          Observer(
            builder: (_) {
              return RegisterTextFieldWidget(
                controller: confirmPasswordController,
                label: 'Confirmar senha',
                hint: 'Repita sua senha',
                prefixIcon: Icons.shield_outlined,
                isPassword: true,
                obscureText: store.obscureConfirmPassword,
                onToggleVisibility: store.toggleConfirmPasswordVisibility,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.newPassword],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (value.length < 8) {
                    return 'A senha deve ter no mínimo 8 caracteres';
                  }
                  return null;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
