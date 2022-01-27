import 'package:flutter/material.dart';

class CardFrontLayout {
  String bankName;
  String? cardNumber;
  String? cardExpiry;
  String? cardHolderName;
  Widget? cardTypeIcon;
  double? cardWidth;
  double? cardHeight;
  Color? textColor;

  String? textExpDate;
  String? textName;
  String? textExpiry;
  final String mask;

  CardFrontLayout({
    this.bankName = '',
    this.cardNumber = '',
    this.cardExpiry = '',
    this.cardHolderName = '',
    this.textExpDate = 'Exp. Date',
    this.textExpiry = 'MM/YY',
    this.textName = 'Card Holder',
    required this.mask,
    this.cardTypeIcon,
    this.cardWidth = 0,
    this.cardHeight = 0,
    this.textColor,
  });

  Widget layout1() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 30,
                child: Center(
                  child: Text(
                    bankName,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'images/contactless_icon.png',
                    fit: BoxFit.fitHeight,
                    width: 30.0,
                    height: 30.0,
                    color: textColor,
                    package: 'awesome_card',
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cardNumber == null || cardNumber!.isEmpty
                            ? mask
                            : cardNumber!,
                        style: TextStyle(
                          package: 'awesome_card',
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'MavenPro',
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            textExpDate!,
                            style: TextStyle(
                                package: 'awesome_card',
                                color: textColor,
                                fontFamily: 'MavenPro',
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            cardExpiry == null || cardExpiry!.isEmpty
                                ? textExpiry!
                                : cardExpiry!,
                            style: TextStyle(
                                package: 'awesome_card',
                                color: textColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'MavenPro',
                                fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 7, // 60% of space => (6/(6 + 4))
                            child: Text(
                              cardHolderName == null || cardHolderName!.isEmpty
                                  ? textName!
                                  : cardHolderName!,
                              style: TextStyle(
                                package: 'awesome_card',
                                color: textColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'MavenPro',
                                fontSize: 17,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 2, // 40% of space
                              child: cardTypeIcon != null
                                  ? cardTypeIcon!
                                  : SizedBox(
                                      width: 10,
                                    )),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
