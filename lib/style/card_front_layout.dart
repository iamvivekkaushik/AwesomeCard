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
  bool? isContactless;

  /// Optional overrides merged over each field's default style.
  TextStyle? bankNameTextStyle;
  TextStyle? cardNumberTextStyle;
  TextStyle? cardExpiryTextStyle;
  TextStyle? cardHolderNameTextStyle;

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
    this.isContactless = true,
    this.bankNameTextStyle,
    this.cardNumberTextStyle,
    this.cardExpiryTextStyle,
    this.cardHolderNameTextStyle,
  });

  /// Scales [child] down to fit the available space instead of overflowing.
  /// Falls back to the unscaled child when no card width is known, since
  /// FittedBox gives unbounded constraints and the child contains Expanded.
  Widget _scaleToFit(double? width, Widget child) {
    if (width == null) {
      return child;
    }
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.bottomLeft,
      child: SizedBox(width: width, child: child),
    );
  }

  Widget layout1() {
    // Bounded width for the bottom info block so it can be scaled down as a
    // whole (via FittedBox) instead of overflowing on small cards.
    // 40 = horizontal padding of this layout.
    final contentWidth =
        (cardWidth ?? 0) > 40 ? cardWidth! - 40 : null;

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
              Flexible(
                child: Container(
                  height: 30,
                  child: Center(
                    child: Text(
                      bankName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                              color: textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)
                          .merge(bankNameTextStyle),
                    ),
                  ),
                ),
              ),
              if(isContactless ?? true)
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
              child: _scaleToFit(
                contentWidth,
                Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          cardNumber == null || cardNumber!.isEmpty
                              ? mask
                              : cardNumber!,
                          style: TextStyle(
                            package: 'awesome_card',
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'MavenPro',
                            fontSize: 22,
                          ).merge(cardNumberTextStyle),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
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
                                      fontSize: 16)
                                  .merge(cardExpiryTextStyle),
                            ),
                          ],
                        ),
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
                              ).merge(cardHolderNameTextStyle),
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
