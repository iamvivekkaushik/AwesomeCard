import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('all awesome_card package assets load from a consumer app', () async {
    const assets = [
      'packages/awesome_card/images/contactless_icon.png',
      'packages/awesome_card/images/card_provider/american_express.png',
      'packages/awesome_card/images/card_provider/diners_club.png',
      'packages/awesome_card/images/card_provider/discover.png',
      'packages/awesome_card/images/card_provider/elo.png',
      'packages/awesome_card/images/card_provider/jcb.png',
      'packages/awesome_card/images/card_provider/maestro.png',
      'packages/awesome_card/images/card_provider/master_card.png',
      'packages/awesome_card/images/card_provider/rupay.png',
      'packages/awesome_card/images/card_provider/visa.png',
    ];
    for (final a in assets) {
      final data = await rootBundle.load(a);
      expect(data.lengthInBytes, greaterThan(0), reason: a);
      // ignore: avoid_print
      print('OK ${data.lengthInBytes} bytes: $a');
    }
  });
}
