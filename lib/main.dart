import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:growstore/core/theme/dark_theme.dart';
import 'package:growstore/features/home/pages/home_page.dart';
import 'package:growstore/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://ucdecpenkxmuuwpmmbgt.supabase.co',
    publishableKey: 'sb_publishable_N_m5Da8h_8SVTl-jOKBLxw_FqTa90VV',
  );

  runApp(const GrowStoreApp());
}

class GrowStoreApp extends StatelessWidget {
  const GrowStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grow Store',
      theme: growDarkTheme,
      home: const HomePage(),
    );
  }
}
