import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growstore/core/theme/colors_theme.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/features/auth/stores/login/login_store.dart';
import 'package:growstore/shared/widgets/figma_phone_canvas.dart';
import 'package:growstore/shared/widgets/growstore_figma_brand.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, LoginStore? loginStore})
    : _loginStore = loginStore;

  final LoginStore? _loginStore;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final LoginStore _loginStore;
  late final AuthStore _authStore;

  @override
  void initState() {
    super.initState();
    _loginStore = widget._loginStore ?? LoginStore();
    _authStore = GetIt.I.get<AuthStore>();
  }

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
        final user = _loginStore.currentUser;

        if (success && user != null) {
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
    final colors = _FigmaLoginColors.fromBrightness(
      Theme.of(context).brightness,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: colors.background,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colors.background,
        body: Form(
          key: _formKey,
          child: FigmaPhoneCanvas(
            backgroundColor: colors.background,
            children: [
              const Positioned(
                left: 80,
                top: 48,
                width: 242,
                height: 136,
                child: GrowStoreFigmaMark(),
              ),
              Positioned(
                left: 47.5,
                top: colors.isDarkTheme ? 241 : 217,
                width: 307,
                height: 25,
                child: GrowStoreFigmaWordmark(isDarkTheme: colors.isDarkTheme),
              ),
              Positioned(
                left: 21,
                top: 366,
                width: 359,
                height: 45,
                child: _FigmaLoginField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  colors: colors,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail';
                    }
                    return null;
                  },
                ),
              ),
              Positioned(
                left: 21,
                top: 440,
                width: 359,
                height: 45,
                child: Observer(
                  builder: (_) {
                    return _FigmaLoginField(
                      controller: _passwordController,
                      hintText: 'Senha',
                      icon: Icons.lock,
                      obscureText: !_loginStore.showPassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _handleLogin(),
                      onTogglePassword: _loginStore.toggleShowPassword,
                      colors: colors,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha';
                        }
                        return null;
                      },
                    );
                  },
                ),
              ),
              Positioned(
                left: 101,
                top: 624,
                width: 200,
                height: 60,
                child: Observer(
                  builder: (_) {
                    return _FigmaPillButton(
                      label: 'ENTRAR',
                      isLoading: _loginStore.isLoading,
                      colors: colors,
                      onPressed: _handleLogin,
                    );
                  },
                ),
              ),
              Positioned(
                left: 101,
                top: 705,
                width: 200,
                height: 60,
                child: _FigmaPillButton(
                  label: 'CRIAR CONTA',
                  colors: colors,
                  onPressed: () => Navigator.of(context).pushNamed('/register'),
                ),
              ),
              Positioned(
                left: colors.isDarkTheme ? 186 : 185,
                top: colors.isDarkTheme ? 781 : 778,
                width: 30,
                height: 30,
                child: Observer(
                  builder: (_) {
                    return _FigmaGoogleButton(
                      isLoading: _loginStore.isGoogleLoading,
                      colors: colors,
                      onPressed: _handleGoogleLogin,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FigmaLoginColors {
  const _FigmaLoginColors({
    required this.isDarkTheme,
    required this.background,
    required this.fieldFill,
    required this.fieldContent,
    required this.buttonFill,
    required this.buttonContent,
    required this.googleFill,
  });

  factory _FigmaLoginColors.fromBrightness(Brightness brightness) {
    final isDarkTheme = brightness == Brightness.dark;

    if (isDarkTheme) {
      return const _FigmaLoginColors(
        isDarkTheme: true,
        background: Color(0xFF0D1B2A),
        fieldFill: GrowColors.darkSurfaceElevated,
        fieldContent: GrowColors.darkTextPrimary,
        buttonFill: GrowColors.primary,
        buttonContent: Colors.white,
        googleFill: GrowColors.darkSurfaceElevated,
      );
    }

    return const _FigmaLoginColors(
      isDarkTheme: false,
      background: GrowColors.primary,
      fieldFill: Colors.white,
      fieldContent: GrowColors.darkTextSecondary,
      buttonFill: Colors.white,
      buttonContent: Color(0xFF191C1D),
      googleFill: Colors.white,
    );
  }

  final bool isDarkTheme;
  final Color background;
  final Color fieldFill;
  final Color fieldContent;
  final Color buttonFill;
  final Color buttonContent;
  final Color googleFill;
}

class _FigmaLoginField extends StatelessWidget {
  const _FigmaLoginField({
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.colors,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.onTogglePassword,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final _FigmaLoginColors colors;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTogglePassword;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(23),
      borderSide: BorderSide.none,
    );

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      cursorColor: colors.buttonFill,
      style: TextStyle(
        color: colors.fieldContent,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1,
        letterSpacing: 0,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: colors.fieldFill,
        hintText: hintText,
        hintStyle: TextStyle(
          color: colors.fieldContent,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1,
          letterSpacing: 0,
        ),
        prefixIcon: Icon(icon, color: colors.fieldContent, size: 30),
        prefixIconConstraints: const BoxConstraints.tightFor(
          width: 66,
          height: 45,
        ),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 52, height: 45),
          icon: Icon(Icons.visibility, color: colors.fieldContent, size: 24),
          onPressed: onTogglePassword,
        ),
        suffixIconConstraints: const BoxConstraints.tightFor(
          width: 52,
          height: 45,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 13),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border.copyWith(
          borderSide: const BorderSide(color: GrowColors.error, width: 1),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: const BorderSide(color: GrowColors.error, width: 1),
        ),
        errorStyle: const TextStyle(height: 0, fontSize: 0),
      ),
    );
  }
}

class _FigmaPillButton extends StatelessWidget {
  const _FigmaPillButton({
    required this.label,
    required this.colors,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final _FigmaLoginColors colors;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return Material(
      color: colors.buttonFill,
      borderRadius: BorderRadius.circular(30),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: colors.buttonContent,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.syne(
                    color: colors.buttonContent,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                    height: 22 / 14,
                    letterSpacing: 0,
                  ),
                ),
        ),
      ),
    );
  }
}

class _FigmaGoogleButton extends StatelessWidget {
  const _FigmaGoogleButton({
    required this.colors,
    required this.onPressed,
    this.isLoading = false,
  });

  final _FigmaLoginColors colors;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.googleFill,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    color: colors.fieldContent,
                    strokeWidth: 2,
                  ),
                )
              : Image.asset(
                  'assets/images/google.png',
                  width: 16,
                  height: 16,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
        ),
      ),
    );
  }
}
