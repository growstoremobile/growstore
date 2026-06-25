import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/theme/colors_theme.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/shared/widgets/figma_phone_canvas.dart';
import 'package:growstore/shared/widgets/growstore_figma_brand.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
    this.redirectDelay = const Duration(milliseconds: 500),
    this.shouldRedirect = true,
  });

  final Duration redirectDelay;
  final bool shouldRedirect;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    if (widget.shouldRedirect) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _redirect());
    }
  }

  Future<void> _redirect() async {
    await Future.delayed(widget.redirectDelay);

    if (!mounted) return;

    final authStore = GetIt.I<AuthStore>();
    final route = authStore.isAuthenticated ? '/home' : '/login';

    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkTheme
        ? const Color(0xFF0D1B2A)
        : GrowColors.primary;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: backgroundColor,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: FigmaPhoneCanvas(
          backgroundColor: backgroundColor,
          children: [
            const Positioned(
              left: 80,
              top: 351,
              width: 242,
              height: 136,
              child: GrowStoreFigmaMark(),
            ),
            Positioned(
              left: 47.5,
              top: 520,
              width: 307,
              height: 25,
              child: GrowStoreFigmaWordmark(isDarkTheme: isDarkTheme),
            ),
          ],
        ),
      ),
    );
  }
}
