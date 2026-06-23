import 'package:flutter_test/flutter_test.dart';

import 'package:growstore/main.dart';

void main() {
  testWidgets('home renders its main storefront sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GrowStoreApp());

    expect(find.text('Buscar produtos...'), findsOneWidget);
    expect(find.text('Todas'), findsOneWidget);
    expect(find.text('Camiseta'), findsOneWidget);
    expect(find.text('Camiseta preta'), findsOneWidget);
    expect(find.text('Kit Adesivos'), findsOneWidget);
    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Pedidos'), findsOneWidget);
  });
}
