import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors_login_page.dart';
import 'package:growstore/features/auth/widgets/login/login_header.dart';
import 'package:growstore/features/auth/widgets/login/login_email_field.dart';
import 'package:growstore/features/auth/widgets/login/login_password_field.dart';
import 'package:growstore/features/auth/widgets/login/login_button.dart';
import 'package:growstore/features/auth/widgets/login/login_divider.dart';
import 'package:growstore/features/auth/widgets/login/login_google_button.dart';
import 'package:growstore/features/auth/widgets/login/login_footer.dart';
import 'package:growstore/features/auth/stores/login_store.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await _loginStore.login(
        _emailController.text,
        _passwordController.text,
      );

      // Garante que o widget ainda está na tela antes de mostrar a mensagem
      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login realizado com sucesso!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_loginStore.error ?? 'Erro ao fazer login')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoginPageColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Container(
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: LoginPageColors.surfaceLowest.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: LoginPageColors.outlineVariant.withValues(
                      alpha: 0.3,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LoginHeader(),
                      const SizedBox(height: 40),
                      LoginEmailField(controller: _emailController),
                      const SizedBox(height: 24),
                      LoginPasswordField(
                        controller: _passwordController,
                        onSubmitted: _handleLogin,
                      ),
                      const SizedBox(height: 32),
                      LoginButton(onPressed: _handleLogin),
                      const SizedBox(height: 32),
                      const LoginDivider(),
                      const SizedBox(height: 24),
                      const LoginGoogleButton(),
                      const SizedBox(height: 32),
                      const LoginFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
