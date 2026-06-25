import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/theme/colors_theme.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
    this.redirectDelay = const Duration(milliseconds: 500),
  });

  final Duration redirectDelay;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _redirect());
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
    return const Scaffold(
      backgroundColor: GrowColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SplashLogo(),
              SizedBox(height: 24),
              Text(
                'GrowStore',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Loja oficial Growdev',
                style: TextStyle(
                  color: Color(0xE6FFFFFF),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .16),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Text(
        'G',
        style: TextStyle(
          color: GrowColors.primary,
          fontSize: 56,
          fontWeight: FontWeight.w900,
          height: 1,
        ),
      ),
    );
  }
}
