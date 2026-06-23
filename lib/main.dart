import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/theme/dark_theme.dart';
import 'package:growstore/features/cart/pages/cart_page.dart';
import 'package:growstore/features/favorites/models/favority_model.dart';
import 'package:growstore/features/favorites/pages/favority_page.dart';
import 'package:growstore/features/favorites/repositories/favority_repository.dart';
import 'package:growstore/features/favorites/services/favority_service.dart';
import 'package:growstore/features/favorites/stores/favority/favority_products_store.dart';
import 'package:growstore/features/home/pages/home_page.dart';
import 'package:growstore/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FavorityModelAdapter());
}

Future<void> initServiceLocator() async {
  final favorityBox = await Hive.openBox("favorities");

  // 1. Registrar o Service
  GetIt.I.registerSingleton<FavorityService>(FavorityService());

  // 2. Registrar o Repository (Injetando o Service)
  GetIt.I.registerSingleton<FavorityRepository>(
    FavorityRepository(
      boxFavoritiesProducts: favorityBox,
      favoriteService: GetIt.I.get<FavorityService>(),
    ),
  );

  GetIt.I.registerSingleton<FavorityProductsStore>(FavorityProductsStore());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHive();
  await initServiceLocator();

  // Inicialização do Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inicialização do Supabase
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
      routes: {
        '/home': (_) => const HomePage(),
        '/cart': (_) => const CartPage(),
        '/favorites': (_) => const FavorityPage(),
      },
    );
  }
}
