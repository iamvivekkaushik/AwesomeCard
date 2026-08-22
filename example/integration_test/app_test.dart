// On-device/simulator integration test driving the real demo app UI.
// Run: flutter test integration_test -d <device>
import 'package:awesome_card/awesome_card.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

Finder brandIcon(String fileName) => find.byWidgetPredicate((w) =>
    w is Image &&
    w.image is AssetImage &&
    (w.image as AssetImage).keyName.contains(fileName));

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('full card flow on a real device/simulator', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    // Empty state: mask shown, no crash (BUG-1 fix).
    expect(find.text('XXXX XXXX XXXX XXXX'), findsOneWidget);
    expect(find.text('Axis Bank'), findsOneWidget);

    final fields = find.byType(TextFormField);

    // Visa detection.
    await tester.enterText(fields.at(0), '4111111111111111');
    await tester.pumpAndSettle();
    expect(find.text('4111 1111 1111 1111'), findsOneWidget);
    expect(brandIcon('visa.png'), findsOneWidget);

    // Elo BIN wins over Visa (BUG-2 fix).
    await tester.enterText(fields.at(0), '4011781234567890');
    await tester.pumpAndSettle();
    expect(brandIcon('elo.png'), findsOneWidget);

    // RuPay 6521 wins over Discover (BUG-2 fix).
    await tester.enterText(fields.at(0), '6521111111111111');
    await tester.pumpAndSettle();
    expect(brandIcon('rupay.png'), findsOneWidget);

    // Expiry and name propagate to the card.
    await tester.enterText(fields.at(1), '12/27');
    await tester.enterText(fields.at(2), 'JOHN DOE');
    await tester.pumpAndSettle();
    expect(find.text('12/27'), findsWidgets);
    expect(find.text('JOHN DOE'), findsWidgets);

    // Focusing CVV flips the card; CVV renders on the back, and the
    // literal "null" never appears (BUG-3 fix).
    await tester.tap(fields.at(3));
    await tester.pumpAndSettle();
    await tester.enterText(fields.at(3), '123');
    await tester.pumpAndSettle();
    expect(find.text('123'), findsWidgets);
    expect(find.text('null'), findsNothing);

    // Focusing the number field flips back to the front.
    await tester.tap(fields.at(0));
    await tester.pumpAndSettle();
    expect(find.byType(CreditCard), findsOneWidget);
  });
}
