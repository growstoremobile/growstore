import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/auth/models/user_model.dart';
import 'package:growstore/features/auth/pages/register_page.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/features/auth/stores/login/login_store.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/home/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginStore = LoginStore();
  final _authStore = GetIt.I.get<AuthStore>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_loginStore.isLoading) return;

    if (_formKey.currentState?.validate() ?? false) {
      final success = await _loginStore.login(
        _emailController.text,
        _passwordController.text,
      );

      // Garante que o widget ainda está na tela antes de mostrar a mensagem
      if (mounted) {
        if (success) {
          // Mock de dados do usuário
          final user = UserModel(
            id: '123',
            name: 'Fulano de Tal',
            email: _emailController.text,
            password: '123456',
          );
          _authStore.setUser(user);

          // Redireciona para a tela inicial e limpa a pilha de navegação
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) =>
                false, // O (route) => false é o que remove as telas de login/cadastro do histórico
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_loginStore.error ?? 'Erro ao fazer login')),
          );
        }
      }
    }
  }

  Future<void> _handleGoogleLogin() async {
    if (_loginStore.isGoogleLoading) return;

    final success = await _loginStore.loginWithGoogle();

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
              _loginStore.error ?? 'Erro ao fazer login com Google',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF38a83d),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: SizedBox(
            height:
                MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).padding.bottom) -
                48,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // BEGIN: LogoSection
                  Column(
                    children: [
                      const SizedBox(height: 48),
                      const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                        size: 150,
                      ),
                      Transform.translate(
                        offset: const Offset(0, -20),
                        child: const Text(
                          'GrowStore',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            letterSpacing: -2.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // END: LogoSection

                  // BEGIN: LoginForm
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _buildInputDecoration(
                            'Email',
                            Icons.email_outlined,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            color: GrowColors.lightTextPrimary,
                          ),
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
                          builder: (_) => TextFormField(
                            controller: _passwordController,
                            obscureText: _loginStore.showPassword,
                            decoration: _buildInputDecoration(
                              'Senha',
                              Icons.lock_outline,
                              isPassword: true,
                              onToggleVisibility:
                                  _loginStore.toggleShowPassword,
                              isObscured: _loginStore.showPassword,
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              color: GrowColors.lightTextPrimary,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira sua senha';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _handleLogin(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // END: LoginForm

                  // BEGIN: ActionButtons
                  Column(
                    children: [
                      Observer(
                        builder: (_) {
                          return _buildAuthButton(
                            text: 'ENTRAR',
                            onPressed: _handleLogin,
                            isLoading: _loginStore.isLoading,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildAuthButton(
                        text: 'CRIAR CONTA',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RegisterPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Observer(
                        builder: (_) {
                          return _loginStore.isGoogleLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : GestureDetector(
                                  onTap: _handleGoogleLogin,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      'assets/icons/google_logo.png',
                                      width: 28,
                                      height: 28,
                                    ),
                                  ),
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
      ),
    );
  }

  InputDecoration _buildInputDecoration(
    String label,
    IconData prefixIcon, {
    bool isPassword = false,
    VoidCallback? onToggleVisibility,
    bool isObscured = false,
  }) {
    return InputDecoration(
      hintText: label,
      hintStyle: const TextStyle(color: GrowColors.lightTextDisabled),
      prefixIcon: Icon(prefixIcon, color: GrowColors.lightTextDisabled),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                isObscured
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: GrowColors.lightTextDisabled,
              ),
              onPressed: onToggleVisibility,
            )
          : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
    );
  }

  Widget _buildAuthButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.8,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 3,
                ),
              )
            : Text(text),
      ),
    );
  }
}
