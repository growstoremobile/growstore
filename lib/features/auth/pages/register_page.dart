import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';
import 'package:growstore/features/auth/widgets/login/login_google_button_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_app_bar_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_background_painter_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_button_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_divider_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_footer_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_header_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_terms_checkbox_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_text_field_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_acceptedTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Você precisa aceitar os Termos de Uso.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      // TODO: Implementar lógica de cadastro
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Stack(
        children: [
          // Background Hero Pattern (Bolinhas pontilhadas)
          Positioned.fill(
            child: CustomPaint(painter: RegisterBackgroundPainterWidget()),
          ),
          // Visual Accent Element (Ícone da planta no canto inferior)
          const Positioned(
            bottom: -20,
            right: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.eco,
                size: 160,
                color: AppColors.growthGreen,
              ),
            ),
          ),
          // Conteúdo Principal
          SafeArea(
            child: Column(
              children: [
                const RegisterAppBarWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 24.0,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const RegisterHeaderWidget(),
                              const SizedBox(height: 40),
                              _buildFormFields(),
                              const SizedBox(height: 24),
                              RegisterTermsCheckboxWidget(
                                value: _acceptedTerms,
                                onChanged: (v) =>
                                    setState(() => _acceptedTerms = v ?? false),
                              ),
                              const SizedBox(height: 24),
                              RegisterButtonWidget(onPressed: _handleRegister),
                              const SizedBox(height: 32),
                              const RegisterDividerWidget(),
                              const SizedBox(height: 24),
                              const LoginGoogleButtonWidget(),
                              const SizedBox(height: 32),
                              const RegisterFooterWidget(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        RegisterTextFieldWidget(
          controller: _nameController,
          label: 'Nome Completo',
          hint: 'Como deseja ser chamado?',
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        RegisterTextFieldWidget(
          controller: _emailController,
          label: 'E-mail Corporativo',
          hint: 'exemplo@growstore.com',
          prefixIcon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        RegisterTextFieldWidget(
          controller: _passwordController,
          label: 'Senha',
          hint: 'Mínimo 8 caracteres',
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          obscureText: _obscurePassword,
          onToggleVisibility: () =>
              setState(() => _obscurePassword = !_obscurePassword),
        ),
        const SizedBox(height: 16),
        RegisterTextFieldWidget(
          controller: _confirmPasswordController,
          label: 'Confirmar Senha',
          hint: 'Repita sua senha',
          prefixIcon: Icons.shield_outlined,
          isPassword: true,
          obscureText: _obscureConfirmPassword,
          onToggleVisibility: () => setState(
            () => _obscureConfirmPassword = !_obscureConfirmPassword,
          ),
        ),
      ],
    );
  }
}
