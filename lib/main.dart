import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/core/di/injection.dart';
import 'package:growstore/core/theme/dark_theme.dart';
import 'package:growstore/core/theme/light_theme.dart';
import 'package:growstore/core/theme/theme_mode_controller.dart';
import 'package:growstore/features/auth/models/user_model.dart';
import 'package:growstore/features/auth/pages/login_page.dart';
import 'package:growstore/features/auth/pages/register_page.dart';
import 'package:growstore/features/auth/stores/auth/auth_store.dart';
import 'package:growstore/features/cart/pages/cart_page.dart';
import 'package:growstore/features/cart/stores/cart/cart_store.dart';
import 'package:growstore/features/categories/pages/category_detail_page.dart';
import 'package:growstore/features/categories/pages/category_page.dart';
import 'package:growstore/features/catalog/pages/product_detail_page.dart';
import 'package:growstore/features/favorites/models/favority_model.dart';
import 'package:growstore/features/favorites/pages/favority_page.dart';
import 'package:growstore/features/favorites/repositories/favority_repository.dart';
import 'package:growstore/features/favorites/services/favority_service.dart';
import 'package:growstore/features/favorites/stores/favority/favority_products_store.dart';
import 'package:growstore/features/home/pages/home_page.dart';
import 'package:growstore/features/home/repositories/home_repository.dart';
import 'package:growstore/features/home/stores/home/home_store.dart';
import 'package:growstore/features/profile/pages/profile_page.dart';
import 'package:growstore/features/search/pages/search_page.dart';
import 'package:growstore/features/splash/pages/splash_page.dart';
import 'package:growstore/firebase_options.dart';
import 'package:growstore/shared/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(FavorityModelAdapter());
  }
}

Future<void> initServiceLocator() async {
  final favorityBox = await Hive.openBox('favorities');
  final authBox = await Hive.openBox('auth');

  GetIt.I.registerSingleton<FavorityService>(FavorityService());
  final authStore = AuthStore();
  final savedToken = authBox.get('token_user') as String?;
  final savedUserId = authBox.get('user_id') as String?;
  final savedUserName = authBox.get('user_name') as String?;
  final savedUserEmail = authBox.get('user_email') as String?;
  final savedUserPhotoUrl = authBox.get('user_photo_url') as String?;

  if (savedToken != null &&
      savedToken.isNotEmpty &&
      savedUserId != null &&
      savedUserName != null &&
      savedUserEmail != null) {
    Constants.userToken = savedToken;
    authStore.setUser(
      UserModel(
        id: savedUserId,
        name: savedUserName,
        email: savedUserEmail,
        photoUrl: savedUserPhotoUrl,
      ),
    );
  }

  GetIt.I.registerSingleton<AuthStore>(authStore);
  GetIt.I.registerSingleton<HomeRepository>(HomeRepository());
  GetIt.I.registerSingleton<HomeStore>(
    HomeStore(GetIt.I.get<HomeRepository>()),
  );

  GetIt.I.registerSingleton<FavorityRepository>(
    FavorityRepository(
      boxFavoritiesProducts: favorityBox,
      favoriteService: GetIt.I.get<FavorityService>(),
    ),
  );
  GetIt.I.registerSingleton<FavorityProductsStore>(FavorityProductsStore());
  if (!GetIt.I.isRegistered<CartStore>()) {
    GetIt.I.registerSingleton<CartStore>(CartStore());
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isNotEmpty) {
      debugPrint("Firebase ja estava inicializado nativamente.");
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      debugPrint("Firebase inicializado com sucesso.");
    }
  } catch (e) {
    debugPrint("Aviso Firebase: $e");
  }

  try {
    await Supabase.initialize(
      url: 'https://ucdecpenkxmuuwpmmbgt.supabase.co',
      publishableKey: 'sb_publishable_N_m5Da8h_8SVTl-jOKBLxw_FqTa90VV',
    );
  } catch (e) {
    debugPrint("Erro Supabase: $e");
  }

  await initHive();
  await initServiceLocator();
  await setupDependencies();

  runApp(const GrowStoreApp());
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
    return ThemeModeController(
      themeMode: _themeMode,
      toggleTheme: _toggleTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grow Store',
        theme: growLightTheme,
        darkTheme: growDarkTheme,
        themeMode: _themeMode,
        routes: {
          '/': (_) => const SplashPage(),
          '/splash': (_) => const SplashPage(),
          '/home': (_) => const HomePage(),
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/search': (_) => const SearchPage(),
          '/categories': (_) => const CategoryPage(),
          '/cart': (_) => const CartPage(),
          '/favorites': (_) => const FavorityPage(),
          '/profile': (_) => ProfilePage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/productDetail') {
            final productId = settings.arguments?.toString();

            return MaterialPageRoute(
              settings: settings,
              builder: (_) {
                if (productId == null || productId.isEmpty) {
                  return const Scaffold(
                    body: Center(child: Text('Produto nao encontrado.')),
                  );
                }

                return ProductDetailPage(productId: productId);
              },
            );
          }

          if (settings.name == '/categoryDetail') {
            final categoryName = settings.arguments?.toString();

            return MaterialPageRoute(
              settings: settings,
              builder: (_) {
                if (categoryName == null || categoryName.isEmpty) {
                  return const CategoryPage();
                }

                return CategoryDetailPage(categoryName: categoryName);
              },
            );
          }

          return null;
        },
      ),
    );
  }
}
