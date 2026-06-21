import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:growstore/features/auth/pages/login_page.dart';
import 'package:growstore/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //Inicialização do Supabase
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://ucdecpenkxmuuwpmmbgt.supabase.co",
    publishableKey: 'sb_publishable_N_m5Da8h_8SVTl-jOKBLxw_FqTa90VV',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}
