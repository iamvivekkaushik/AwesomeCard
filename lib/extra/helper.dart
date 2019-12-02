import 'package:flutter/material.dart';

Widget getCardTypeIcon(String cardNumber) {
  switch(getCardType(cardNumber)) {
    case CardType.americanExpress:
      return Image.asset(
        "images/card_provider/american_express.png",
        width: 55,
        height: 40,
        package: 'awesome_card',
      );
    case CardType.dinersClub:
      return Image.asset(
        "images/card_provider/diners_club.png",
        width: 40,
        height: 40,
        package: 'awesome_card',
      );
    case CardType.discover:
      return Image.asset(
        "images/card_provider/discover.png",
        width: 70,
        height: 50,
        package: 'awesome_card',
      );
    case CardType.jcb:
      return Image.asset(
        "images/card_provider/jcb.png",
        width: 40,
        height: 40,
        package: 'awesome_card',
      );
    case CardType.masterCard:
      return Image.asset(
        "images/card_provider/master_card.png",
        width: 55,
        height: 40,
        package: 'awesome_card',
      );
    case CardType.rupay:
      return Image.asset(
        "images/card_provider/rupay.png",
        width: 80,
        height: 50,
        package: 'awesome_card',
      );
    case CardType.visa:
      return Image.asset(
        "images/card_provider/visa.png",
        width: 55,
        height: 40,
        package: 'awesome_card',
      );
    default:
      return Container();
  }
}

CardType getCardType(String cardNumber) {
  return CardType.masterCard;
}

enum CardType {
  americanExpress,
  dinersClub,
  discover,
  jcb,
  masterCard,
  rupay,
  visa,
  other
}