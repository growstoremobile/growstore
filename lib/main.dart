import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/auth/pages/login_page.dart';
import 'package:growstore/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: growLightTheme,
      darkTheme: growDarkTheme,
      home: const LoginPage(),
    );
  }
}
