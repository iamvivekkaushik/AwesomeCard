// Smoke test for the card demo app.
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('Card demo smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(CreditCard), findsOneWidget);
    expect(find.text('Axis Bank'), findsOneWidget);

    // Typing a Visa number updates the card.
    await tester.enterText(find.byType(TextFormField).first, '4111111111111111');
    await tester.pumpAndSettle();
    expect(find.textContaining('4111'), findsWidgets);
  });
}
