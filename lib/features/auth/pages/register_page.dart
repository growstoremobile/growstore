import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/features/auth/stores/register/register_store.dart';
import 'package:growstore/features/auth/widgets/login/login_google_button_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_app_bar_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_background_painter_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_button_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_divider_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_footer_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_form_fields_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_header_widget.dart';
import 'package:growstore/features/auth/widgets/register/register_terms_checkbox_widget.dart';

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
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );

      if (mounted) {
        if (success) {
          final user = _registerStore.currentUser;
          if (user != null) {
            _authStore.setUser(user);
          }

          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/home', (route) => false);
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
        final user = _registerStore.currentUser;
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
              _registerStore.error ?? 'Erro ao fazer login com Google',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final cardBorderColor = colorScheme.outline.withValues(
      alpha: isDark ? 0.35 : 0.18,
    );
    final cardShadowColor = Colors.black.withValues(
      alpha: isDark ? 0.22 : 0.08,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: theme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorScheme.surface,
                      theme.scaffoldBackgroundColor,
                      colorScheme.primaryContainer.withValues(
                        alpha: isDark ? 0.18 : 0.12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: RegisterBackgroundPainterWidget(
                  color: colorScheme.primary.withValues(
                    alpha: isDark ? 0.08 : 0.06,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -36,
              right: -28,
              child: Icon(
                Icons.eco_rounded,
                size: 184,
                color: colorScheme.primary.withValues(
                  alpha: isDark ? 0.08 : 0.07,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  const RegisterAppBarWidget(),
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 460),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: colorScheme.surface.withValues(
                                alpha: isDark ? 0.96 : 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: cardBorderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: cardShadowColor,
                                  blurRadius: 28,
                                  offset: const Offset(0, 18),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const RegisterHeaderWidget(),
                                  const SizedBox(height: 16),
                                  RegisterFormFieldsWidget(
                                    nameController: _nameController,
                                    emailController: _emailController,
                                    passwordController: _passwordController,
                                    confirmPasswordController:
                                        _confirmPasswordController,
                                    store: _registerStore,
                                  ),
                                  const SizedBox(height: 12),
                                  Observer(
                                    builder: (_) {
                                      return RegisterTermsCheckboxWidget(
                                        value: _registerStore.acceptedTerms,
                                        onChanged: (v) => _registerStore
                                            .setAcceptedTerms(v ?? false),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  Observer(
                                    builder: (_) {
                                      return RegisterButtonWidget(
                                        isLoading: _registerStore.isLoading,
                                        onPressed: _handleRegister,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  const RegisterDividerWidget(),
                                  const SizedBox(height: 12),
                                  Observer(
                                    builder: (_) {
                                      return LoginGoogleButtonWidget(
                                        isLoading:
                                            _registerStore.isGoogleLoading,
                                        onPressed: _handleGoogleLogin,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  const RegisterFooterWidget(),
                                ],
                              ),
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
      ),
    );
  }
}
