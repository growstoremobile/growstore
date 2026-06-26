import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/auth/pages/register_page.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/features/auth/stores/login/login_store.dart';
import 'package:growstore/features/auth/widgets/auth_button_widget.dart';
import 'package:growstore/features/auth/widgets/auth_input_decoration.dart';
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
      final user = await _loginStore.login(
        _emailController.text,
        _passwordController.text,
      );

      // Garante que o widget ainda está na tela antes de mostrar a mensagem
      if (mounted) {
        if (user != null) {
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
                      Image.asset('assets/images/G-logomarca.png'),
                      const SizedBox(height: 30),
                      Image.asset('assets/images/GrowStore-logomarca.png'),
                    ],
                  ),
                  // END: LogoSection

                  // BEGIN: LoginForm
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                            isObscured: !_loginStore.showPassword,
                            onToggleVisibility: _loginStore.toggleShowPassword,
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
                          return AuthButtonWidget(
                            text: 'ENTRAR',
                            onPressed: _handleLogin,
                            isLoading: _loginStore.isLoading,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      AuthButtonWidget(
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
                                  color: Color(0xFF38a83d),
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
                                      'assets/images/google.png',
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
}
