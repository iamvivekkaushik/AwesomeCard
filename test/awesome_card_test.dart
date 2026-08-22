import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('null safety (BUG-1)', () {
    test('getCardTypeIcon handles null cardNumber and cardType', () {
      expect(getCardTypeIcon(cardType: null, cardNumber: null), isA<Widget>());
    });

    test('getCardTypeMask handles null cardNumber and cardType', () {
      expect(getCardTypeMask(cardType: null, cardNumber: null),
          'XXXX XXXX XXXX XXXX');
    });

    testWidgets('CreditCard builds with only required parameters',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CreditCard(
          frontBackground: CardBackgrounds.black,
          backBackground: CardBackgrounds.white,
        ),
      ));
      expect(tester.takeException(), isNull);
      expect(find.byType(CreditCard), findsOneWidget);
    });
  });

  group('card type detection (BUG-2)', () {
    test('common brands', () {
      expect(getCardType('4111111111111111'), CardType.visa);
      expect(getCardType('5511111111111111'), CardType.masterCard);
      expect(getCardType('371111111111111'), CardType.americanExpress);
      expect(getCardType('30561111111111'), CardType.dinersClub);
      expect(getCardType('3528111111111111'), CardType.jcb);
      expect(getCardType('5018111111111111'), CardType.maestro);
      expect(getCardType(''), CardType.other);
    });

    test('RuPay 6521/6522 and 60 are RuPay; 6011 is Discover', () {
      expect(getCardType('6521111111111111'), CardType.rupay);
      expect(getCardType('6522111111111111'), CardType.rupay);
      expect(getCardType('6070111111111111'), CardType.rupay);
      expect(getCardType('6011111111111111'), CardType.discover);
    });

    test('Elo BINs win over Visa and Discover prefixes', () {
      expect(getCardType('4011781234567890'), CardType.elo);
      expect(getCardType('4011791234567890'), CardType.elo);
      expect(getCardType('6516601234567890'), CardType.elo);
      expect(getCardType('6550001234567890'), CardType.elo);
      expect(getCardType('6362971234567890'), CardType.elo);
    });

    test('plain 65 remains Discover', () {
      expect(getCardType('6511111111111111'), CardType.discover);
    });
  });

  group('cvv rendering (BUG-3)', () {
    testWidgets('null cvv does not render the literal "null"', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CreditCard(
          cardNumber: '4111111111111111',
          showBackSide: true,
          frontBackground: CardBackgrounds.black,
          backBackground: CardBackgrounds.white,
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.text('null'), findsNothing);
    });

    testWidgets('provided cvv is shown', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CreditCard(
          cardNumber: '4111111111111111',
          cvv: '123',
          showBackSide: true,
          frontBackground: CardBackgrounds.black,
          backBackground: CardBackgrounds.white,
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.text('123'), findsOneWidget);
    });
  });

  group('CardBackgrounds (BUG-4)', () {
    test('custom accepts an int color value', () {
      // The parameter is typed as int, so passing a Color object is now a
      // compile-time error instead of a runtime TypeError.
      expect(CardBackgrounds.custom(0xff112233), isA<Widget>());
    });
  });

  group('narrow card layout (BUG-5)', () {
    for (final width in [220.0, 150.0]) {
      testWidgets('width $width renders without overflow', (tester) async {
        await tester.pumpWidget(MaterialApp(
          home: CreditCard(
            cardNumber: '4111 1111 1111 1111',
            cardHolderName: 'A Very Long Cardholder Name',
            cvv: '123',
            width: width,
            frontBackground: CardBackgrounds.black,
            backBackground: CardBackgrounds.white,
          ),
        ));
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('back side of a narrow card renders without overflow',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CreditCard(
          cardNumber: '4111 1111 1111 1111',
          cvv: '123',
          width: 220,
          showBackSide: true,
          frontBackground: CardBackgrounds.black,
          backBackground: CardBackgrounds.white,
        ),
      ));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });

  group('text style overrides (issue #4)', () {
    testWidgets('overrides merge over defaults on the front', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CreditCard(
          cardNumber: '4111 1111 1111 1111',
          cardHolderName: 'John Doe',
          bankName: 'Test Bank',
          frontBackground: CardBackgrounds.black,
          backBackground: CardBackgrounds.white,
          cardNumberTextStyle: TextStyle(fontSize: 30, letterSpacing: 3),
          cardHolderNameTextStyle: TextStyle(fontStyle: FontStyle.italic),
          bankNameTextStyle: TextStyle(fontSize: 25),
        ),
      ));

      final number = tester.widget<Text>(find.text('4111 1111 1111 1111'));
      expect(number.style!.fontSize, 30);
      expect(number.style!.letterSpacing, 3);
      // Unspecified properties keep their defaults.
      expect(number.style!.fontFamily, 'packages/awesome_card/MavenPro');
      expect(number.style!.color, Colors.white);

      final holder = tester.widget<Text>(find.text('John Doe'));
      expect(holder.style!.fontStyle, FontStyle.italic);
      expect(holder.style!.fontSize, 17);
      expect(holder.style!.overflow, TextOverflow.ellipsis);

      final bank = tester.widget<Text>(find.text('Test Bank'));
      expect(bank.style!.fontSize, 25);
    });

    testWidgets('cvv style override applies on the back', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CreditCard(
          cardNumber: '4111111111111111',
          cvv: '123',
          showBackSide: true,
          frontBackground: CardBackgrounds.black,
          backBackground: CardBackgrounds.white,
          cvvTextStyle: TextStyle(fontSize: 30, color: Colors.red),
        ),
      ));
      await tester.pumpAndSettle();

      final cvv = tester.widget<Text>(find.text('123'));
      expect(cvv.style!.fontSize, 30);
      expect(cvv.style!.color, Colors.red);
      expect(cvv.style!.fontWeight, FontWeight.w500);
    });
  });

  group('flip animation', () {
    testWidgets('static child subtree is not rebuilt per frame',
        (tester) async {
      var buildCount = 0;
      final probe = Builder(builder: (context) {
        buildCount++;
        return const SizedBox();
      });

      Widget app(bool back) => MaterialApp(
            home: CreditCard(
              cardNumber: '4111111111111111',
              showBackSide: back,
              frontBackground: CardBackgrounds.black,
              backBackground: CardBackgrounds.white,
              frontLayout: probe,
            ),
          );

      await tester.pumpWidget(app(false));
      final initial = buildCount;

      await tester.pumpWidget(app(true));
      for (var i = 0; i < 60; i++) {
        await tester.pump(const Duration(milliseconds: 16));
      }
      expect(buildCount - initial, lessThan(3));
    });
  });
}
