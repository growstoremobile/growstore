import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/features/auth/stores/register/register_store.dart';
import 'package:growstore/features/auth/widgets/auth_button_widget.dart';
import 'package:growstore/features/auth/widgets/auth_input_decoration.dart';
import 'package:growstore/features/home/pages/home_page.dart';

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
      final user = await _registerStore.register(
        name: _nameController.text,
        email: _emailController.text,
        pass: _passwordController.text,
      );

      if (mounted) {
        if (user != null) {
          _authStore.setUser(user);
          // Navega para a HomePage e limpa a pilha de navegação
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_registerStore.error ?? 'Erro ao criar conta'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF38a83d),
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: const Color(0xFF38a83d),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BEGIN: LogoSection
                Column(
                  children: [
                    Image.asset('assets/images/G-logomarca.png', height: 100),
                    const SizedBox(height: 30),
                    Image.asset(
                      'assets/images/GrowStore-logomarca.png',
                      width: 250,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
                // END: LogoSection

                // BEGIN: RegisterForm
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AuthInputWidget(
                        controller: _nameController,
                        label: 'Nome',
                        prefixIcon: Icons.person,
                        validator: (value) => (value?.isEmpty ?? true)
                            ? 'Por favor, insira seu nome'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      AuthInputWidget(
                        controller: _emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu email';
                          }
                          if (!value.contains('@')) {
                            return 'Por favor, insira um email válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Observer(
                        builder: (_) => AuthInputWidget(
                          controller: _passwordController,
                          label: 'Senha',
                          prefixIcon: Icons.lock,
                          isPassword: true,
                          isObscured: _registerStore.obscurePassword,
                          onToggleVisibility:
                              _registerStore.togglePasswordVisibility,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira sua senha';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => _handleRegister(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Observer(
                        builder: (_) => AuthInputWidget(
                          controller: _confirmPasswordController,
                          label: 'Confirmar Senha',
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          isObscured: _registerStore.obscureConfirmPassword,
                          onToggleVisibility:
                              _registerStore.toggleConfirmPasswordVisibility,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, confirme sua senha';
                            }
                            if (value != _passwordController.text) {
                              return 'As senhas não coincidem';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => _handleRegister(),
                        ),
                      ),
                    ],
                  ),
                ),
                // END: RegisterForm

                // BEGIN: ActionButtons
                Column(
                  children: [
                    const SizedBox(height: 24),
                    Observer(
                      builder: (_) {
                        return AuthButtonWidget(
                          text: 'CRIAR CONTA',
                          onPressed: _handleRegister,
                          isLoading: _registerStore.isLoading,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                // END: ActionButtons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
