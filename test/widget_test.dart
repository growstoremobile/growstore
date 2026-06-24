import 'package:flutter/material.dart';
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
    expect(find.byIcon(Icons.person_outline_rounded), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);

    await tester.tap(find.text('Mochila'));
    await tester.pumpAndSettle();

    expect(find.text('Mochila Notebook'), findsOneWidget);
    expect(find.text('Camiseta preta'), findsNothing);

    await tester.tap(find.byIcon(Icons.dark_mode_rounded));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);
  });
}
