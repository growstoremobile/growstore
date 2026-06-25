import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/auth/models/user_model.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/features/auth/stores/login/login_store.dart';
import 'package:growstore/features/auth/widgets/login/login_button_widget.dart';
import 'package:growstore/features/auth/widgets/login/login_divider_widget.dart';
import 'package:growstore/features/auth/widgets/login/login_email_field_widget.dart';
import 'package:growstore/features/auth/widgets/login/login_footer_widget.dart';
import 'package:growstore/features/auth/widgets/login/login_google_button_widget.dart';
import 'package:growstore/features/auth/widgets/login/login_header_widget.dart';
import 'package:growstore/features/auth/widgets/login/login_password_field_widget.dart';
import 'package:growstore/shared/colors/colors.dart';

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

      if (mounted) {
        if (success) {
          final user = UserModel(
            id: '123',
            name: 'Fulano de Tal',
            email: _emailController.text,
            password: '123456',
          );
          _authStore.setUser(user);

          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/home', (route) => false);
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
        final user = _loginStore.currentUser;
        if (user != null) {
          _authStore.setUser(user);
        }

        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/home', (route) => false);
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
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Container(
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLowest.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.3),
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
                      const LoginHeaderWidget(),
                      const SizedBox(height: 40),
                      LoginEmailFieldWidget(controller: _emailController),
                      const SizedBox(height: 24),
                      LoginPasswordFieldWidget(
                        controller: _passwordController,
                        onSubmitted: _handleLogin,
                        store: _loginStore,
                      ),
                      const SizedBox(height: 32),
                      Observer(
                        builder: (_) {
                          return LoginButtonWidget(
                            isLoading: _loginStore.isLoading,
                            onPressed: _handleLogin,
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      const LoginDividerWidget(),
                      const SizedBox(height: 24),
                      Observer(
                        builder: (_) {
                          return LoginGoogleButtonWidget(
                            isLoading: _loginStore.isGoogleLoading,
                            onPressed: _handleGoogleLogin,
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      const LoginFooterWidget(),
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
