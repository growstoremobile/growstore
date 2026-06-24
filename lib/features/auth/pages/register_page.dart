import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/auth/models/user_model.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/features/home/pages/home_page.dart';
import 'package:growstore/shared/colors/colors.dart';
import 'package:growstore/features/auth/widgets/login/login_google_button_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_app_bar_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_background_painter_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_button_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_divider_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_footer_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_header_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_terms_checkbox_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_form_fields_widget.dart';
import 'package:growstore/features/auth/stores/register/register_store.dart';

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

  final _registerStore = RegisterStore();
  final _authStore = GetIt.I.get<AuthStore>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_registerStore.isLoading) return;

    if (_formKey.currentState?.validate() ?? false) {
      if (!_registerStore.acceptedTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Você precisa aceitar os Termos de Uso.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('As senhas não coincidem.')),
        );
        return;
      }

      final success = await _registerStore.register(
        _emailController.text,
        _passwordController.text,
      );

      if (mounted) {
        if (success) {
          // Cria o modelo do usuário com os dados do formulário
          final user = UserModel(
            id: 'new_user_id', // Idealmente, este ID viria da resposta da API
            name: _nameController.text,
            email: _emailController.text,
          );
          // Salva o usuário no store global de autenticação
          _authStore.setUser(user);

          // Redireciona para a tela inicial e limpa a pilha de navegação
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) =>
                false, // O (route) => false é o que remove as telas de login/cadastro do histórico
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_registerStore.error ?? 'Erro ao cadastrar'),
            ),
          );
        }
      }
    }
  }

  Future<void> _handleGoogleLogin() async {
    if (_registerStore.isGoogleLoading) return;

    final success = await _registerStore.loginWithGoogle();

    if (mounted) {
      if (success) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                const Scaffold(body: Center(child: Text('Sua Home Page Aqui'))),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _registerStore.error ?? 'Erro ao fazer login com Google',
            ),
          ),
        );
      }
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
              child: Icon(Icons.eco, size: 160, color: AppColors.growthGreen),
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
                              RegisterFormFieldsWidget(
                                nameController: _nameController,
                                emailController: _emailController,
                                passwordController: _passwordController,
                                confirmPasswordController:
                                    _confirmPasswordController,
                                store: _registerStore,
                              ),
                              const SizedBox(height: 24),
                              Observer(
                                builder: (_) {
                                  return RegisterTermsCheckboxWidget(
                                    value: _registerStore.acceptedTerms,
                                    onChanged: (v) => _registerStore
                                        .setAcceptedTerms(v ?? false),
                                  );
                                },
                              ),
                              const SizedBox(height: 24),
                              Observer(
                                builder: (_) {
                                  return RegisterButtonWidget(
                                    isLoading: _registerStore.isLoading,
                                    onPressed: () {
                                      _handleRegister();
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 32),
                              const RegisterDividerWidget(),
                              const SizedBox(height: 24),
                              Observer(
                                builder: (_) {
                                  return LoginGoogleButtonWidget(
                                    isLoading: _registerStore.isGoogleLoading,
                                    onPressed: _handleGoogleLogin,
                                  );
                                },
                              ),
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
}
