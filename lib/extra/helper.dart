import 'package:awesome_card/extra/card_brand.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:flutter/material.dart';

// Detection patterns, compiled once. Order of use matters: Elo BINs are
// 6-digit specific and overlap the broader Visa (4...) and Discover (65...)
// ranges, so Elo must be tested before both.
final RegExp _rAmericanExpress = RegExp(r'^3[47][0-9]{0,}$');
final RegExp _rDinersClub = RegExp(r'^3(?:0[0-59]{1}|[689])[0-9]{0,}$');
final RegExp _rDiscover = RegExp(
    r'^(6011|65|64[4-9]|62212[6-9]|6221[3-9]|622[2-8]|6229[01]|62292[0-5])[0-9]{0,}$');
final RegExp _rJcb = RegExp(r'^(?:2131|1800|35)[0-9]{0,}$');
final RegExp _rMasterCard =
    RegExp(r'^(5[1-5]|222[1-9]|22[3-9]|2[3-6]|27[01]|2720)[0-9]{0,}$');
final RegExp _rMaestro = RegExp(r'^(5[06789]|6)[0-9]{0,}$');
final RegExp _rRupay = RegExp(r'^(6522|6521|60)[0-9]{0,}$');
final RegExp _rVisa = RegExp(r'^4[0-9]{0,}$');
final RegExp _rElo = RegExp(
    r'^(4011(78|79)|43(1274|8935)|45(1416|7393|763(1|2))|50(4175|6699|67[0-7][0-9]|9000)|50(9[0-9][0-9][0-9])|627780|63(6297|6368)|650(03([^4])|04([0-9])|05(0|1)|05([7-9])|06([0-9])|07([0-9])|08([0-9])|4([0-3][0-9]|8[5-9]|9[0-9])|5([0-9][0-9]|3[0-8])|9([0-6][0-9]|7[0-8])|7([0-2][0-9])|541|700|720|727|901)|65165([2-9])|6516([6-7][0-9])|65500([0-9])|6550([0-5][0-9])|655021|65505([6-7])|6516([8-9][0-9])|65170([0-4]))');
// Discover cards that also match RuPay's `60` prefix start with 6011.
final RegExp _rDiscover6011 = RegExp(r'^6011');

/// Returns the first custom brand whose pattern matches [cardNumber]
/// (spaces ignored), or null when there is no match.
CardBrand? matchCustomBrand(String? cardNumber, List<CardBrand>? brands) {
  if (brands == null || brands.isEmpty) {
    return null;
  }
  final number = cardNumber?.trim().replaceAll(' ', '') ?? '';
  if (number.isEmpty) {
    return null;
  }
  for (final brand in brands) {
    if (brand.pattern.hasMatch(number)) {
      return brand;
    }
  }
  return null;
}

Widget getCardTypeIcon(
    {CardType? cardType, String? cardNumber, List<CardBrand>? customBrands}) {
  // An explicit cardType always wins; custom brands are consulted next,
  // before the built-in detection.
  if (cardType == null) {
    final custom = matchCustomBrand(cardNumber, customBrands);
    if (custom != null) {
      return custom.icon;
    }
  }
  switch (cardType ?? getCardType(cardNumber ?? '')) {
    case CardType.americanExpress:
      return Image.asset(
        'images/card_provider/american_express.png',
        width: 55,
        height: 40,
        package: 'awesome_card',
      );
    case CardType.dinersClub:
      return Image.asset(
        'images/card_provider/diners_club.png',
        width: 40,
        height: 40,
        package: 'awesome_card',
      );
    case CardType.discover:
      return Image.asset(
        'images/card_provider/discover.png',
        width: 70,
        height: 50,
        package: 'awesome_card',
      );
    case CardType.jcb:
      return Image.asset(
        'images/card_provider/jcb.png',
        width: 40,
        height: 40,
        package: 'awesome_card',
      );
    case CardType.masterCard:
      return Image.asset(
        'images/card_provider/master_card.png',
        width: 55,
        height: 40,
        package: 'awesome_card',
      );
    case CardType.maestro:
      return Image.asset(
        'images/card_provider/maestro.png',
        width: 55,
        height: 40,
        package: 'awesome_card',
      );
    case CardType.rupay:
      return Image.asset(
        'images/card_provider/rupay.png',
        width: 80,
        height: 50,
        package: 'awesome_card',
      );
    case CardType.visa:
      return Image.asset(
        'images/card_provider/visa.png',
        width: 55,
        height: 40,
        package: 'awesome_card',
      );
    case CardType.elo:
      return Image.asset(
        'images/card_provider/elo.png',
        width: 50,
        height: 50,
        package: 'awesome_card',
      );
    default:
      return Container();
  }
}

/// https://baymard.com/checkout-usability/credit-card-patterns
String getCardTypeMask(
    {CardType? cardType, String? cardNumber, List<CardBrand>? customBrands}) {
  if (cardType == null) {
    final custom = matchCustomBrand(cardNumber, customBrands);
    if (custom != null) {
      return custom.mask ?? 'XXXX XXXX XXXX XXXX';
    }
  }
  final trimmedCardLength = cardNumber?.replaceAll(' ', '').length;
  switch (cardType ?? getCardType(cardNumber ?? '')) {
    case CardType.americanExpress:
      return 'XXXX XXXXXX XXXXX';

    case CardType.dinersClub:
      if (trimmedCardLength == 14) {
        return 'XXXX XXXXXX XXXX';
      }
      return 'XXXX XXXX XXXX XXXX';

    case CardType.discover:
      return 'XXXX XXXX XXXX XXXX';

    case CardType.jcb:
      return 'XXXX XXXX XXXX XXXX';

    case CardType.masterCard:
      return 'XXXX XXXX XXXX XXXX';

    case CardType.maestro:
      if (trimmedCardLength == 13) {
        return 'XXXX XXXX XXXXX';
      } else if (trimmedCardLength == 15) {
        return 'XXXX XXXXXX XXXXX';
      } else if (trimmedCardLength == 19) {
        return 'XXXX XXXX XXXX XXXX XXX';
      }
      return 'XXXX XXXX XXXX XXXX';

    case CardType.rupay:
      return 'XXXX XXXX XXXX XXXX';

    case CardType.visa:
      return 'XXXX XXXX XXXX XXXX';

    case CardType.elo:
      return 'XXXX XXXX XXXX XXXX';
    default:
      return 'XXXX XXXX XXXX XXXX';
  }
}

CardType getCardType(String cardNumber) {
  // Remove all the spaces from the card number
  cardNumber = cardNumber.trim().replaceAll(' ', '');

  if (cardNumber.isEmpty) {
    return CardType.other;
  }

  if (_rAmericanExpress.hasMatch(cardNumber)) {
    return CardType.americanExpress;
  } else if (_rMasterCard.hasMatch(cardNumber)) {
    return CardType.masterCard;
  } else if (_rElo.hasMatch(cardNumber)) {
    // Elo BINs overlap Visa (4011 78/79) and Discover (65...) prefixes,
    // so this check must come before both.
    return CardType.elo;
  } else if (_rVisa.hasMatch(cardNumber)) {
    return CardType.visa;
  } else if (_rDinersClub.hasMatch(cardNumber)) {
    return CardType.dinersClub;
  } else if (_rRupay.hasMatch(cardNumber)) {
    // RuPay and Discover overlap on the `60` prefix: 6011 is Discover,
    // every other 60/6521/6522 card is RuPay.
    if (_rDiscover6011.hasMatch(cardNumber)) {
      return CardType.discover;
    } else {
      return CardType.rupay;
    }
  } else if (_rDiscover.hasMatch(cardNumber)) {
    return CardType.discover;
  } else if (_rJcb.hasMatch(cardNumber)) {
    return CardType.jcb;
  } else if (_rMaestro.hasMatch(cardNumber)) {
    return CardType.maestro;
  }

  return CardType.other;
}
