import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:growstore/core/routing/app_routes.dart';
import 'package:growstore/core/di/injection.dart';
import 'package:growstore/core/theme/growstore_theme.dart';
import 'package:growstore/core/theme/light_theme.dart';
import 'package:growstore/features/address/pages/address_form_page.dart';
import 'package:growstore/features/address/pages/address_list_page.dart';
import 'package:growstore/features/auth/pages/login_page.dart';
import 'package:growstore/features/cart/pages/cart_page.dart';
import 'package:growstore/features/checkout/pages/checkout_page.dart';
import 'package:growstore/features/orders/pages/order_detail_page.dart';

import 'package:growstore/firebase_options.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //Inicialização do Supabase
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://ucdecpenkxmuuwpmmbgt.supabase.co",
    publishableKey: 'sb_publishable_N_m5Da8h_8SVTl-jOKBLxw_FqTa90VV',
  );

  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        AppRoutes.addressList: (context) => const AddressListPage(),
        AppRoutes.addressForm: (context) => const AddressFormPage(),
        AppRoutes.orderDetail: (context) => const OrderDetailPage(),
        AppRoutes.checkout: (context) => const CheckoutPage(),
        AppRoutes.cartPage: (context) => const CartPage(),
      },
      theme: growLightTheme,
      home: const LoginPage(),
    );
  }
}
