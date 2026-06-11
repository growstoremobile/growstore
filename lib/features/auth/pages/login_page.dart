import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors_login_page.dart';
import 'package:growstore/features/auth/widgets/login_header.dart';
import 'package:growstore/features/auth/widgets/login_email_field.dart';
import 'package:growstore/features/auth/widgets/login_password_field.dart';
import 'package:growstore/features/auth/widgets/login_button.dart';
import 'package:growstore/features/auth/widgets/login_divider.dart';
import 'package:growstore/features/auth/widgets/login_google_button.dart';
import 'package:growstore/features/auth/widgets/login_footer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Integrar com AuthService
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Processando login...')));
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
