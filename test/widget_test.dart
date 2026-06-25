import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:growstore/features/home/repositories/home_repository.dart';
import 'package:growstore/features/home/stores/home/home_store.dart';
import 'package:growstore/main.dart';
import 'package:growstore/shared/products/services/product_service.dart';

void main() {
  setUp(() async {
    await GetIt.I.reset();
    GetIt.I.registerSingleton<HomeStore>(
      HomeStore(HomeRepository(productService: _FakeProductService())),
    );
  });

  tearDown(() async {
    await GetIt.I.reset();
  });

  testWidgets('home renders its main storefront sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GrowStoreApp());
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Buscar produtos...'), findsOneWidget);
    expect(find.text('Todas'), findsOneWidget);
    expect(find.text('Camiseta'), findsOneWidget);
    expect(find.text('Camiseta preta'), findsOneWidget);
    expect(find.text('Kit Adesivos'), findsOneWidget);
    expect(find.text('Inicio'), findsOneWidget);
    expect(find.text('Pedidos'), findsOneWidget);
    expect(find.byIcon(Icons.person_outline_rounded), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);

    await tester.tap(find.text('Mochila'));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Mochila Notebook'), findsOneWidget);
    expect(find.text('Camiseta preta'), findsNothing);

    await tester.tap(find.byIcon(Icons.dark_mode_rounded));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);
  });
}

class _FakeProductService implements ProductService {
  @override
  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    return [
      {
        'id': 13,
        'title': 'Camiseta preta',
        'category': 'Camiseta',
        'price': 79.90,
        'image': 'assets/images/figma_home_product_tshirt.png',
      },
      {
        'id': 5,
        'title': 'Kit Adesivos',
        'category': 'Adesivos',
        'price': 5.90,
        'image': 'assets/images/figma_home_product_stickers.png',
      },
      {
        'id': 9,
        'title': 'Mochila Notebook',
        'category': 'Mochila',
        'price': 129.90,
        'image': 'assets/images/figma_home_product_backpack.png',
      },
    ];
  }
}
