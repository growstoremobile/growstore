import 'package:flutter_test/flutter_test.dart';

import 'package:growstore/main.dart';

void main() {
  testWidgets('home renders its main storefront sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GrowStoreApp());

    expect(find.text('GROW STORE'), findsOneWidget);
    expect(find.text('GEAR THAT'), findsOneWidget);
    expect(find.text('BUILDS MORE'), findsOneWidget);
    expect(find.text('SHOP BY CATEGORY'), findsOneWidget);
    expect(find.text('JOIN THE GROW\nCREW'), findsOneWidget);
  });
}
