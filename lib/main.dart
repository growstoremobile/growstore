import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:growstore/core/di/injection.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/features/catalog/pages/product_detail_page.dart';
import 'package:growstore/features/favorites/models/favority_model.dart';
import 'package:growstore/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(FavorityModelAdapter());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://ucdecpenkxmuuwpmmbgt.supabase.co',
    url: 'https://ucdecpenkxmuuwpmmbgt.supabase.co',
    publishableKey: 'sb_publishable_N_m5Da8h_8SVTl-jOKBLxw_FqTa90VV',
  );
  await setupDependencies();
  runApp(const MyApp());
}

class GrowStoreApp extends StatefulWidget {
  const GrowStoreApp({super.key});

  @override
  State<GrowStoreApp> createState() => _GrowStoreAppState();
}

class _GrowStoreAppState extends State<GrowStoreApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(Brightness currentBrightness) {
    setState(() {
      _themeMode = currentBrightness == Brightness.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrowStore',
      debugShowCheckedModeBanner: false,
      theme: growLightTheme,
      darkTheme: growDarkTheme,
      themeMode: ThemeMode.dark,
      home: const ProductDetailPage(productId: '123'),
    );
  }
}
