import 'package:flutter/material.dart';

class CardBackLayout {
  String? cvv;
  double? width;
  double? height;
  Color? color;

  /// Optional override merged over the default CVV style.
  TextStyle? cvvTextStyle;

  CardBackLayout(
      {this.cvv,
      this.width,
      this.height,
      this.color,
      this.cvvTextStyle});

  Widget layout1() {
    // Section heights are proportional to the card height so the layout
    // fits any card size (fixed heights overflowed cards shorter than 150).
    // At the default card height (~200) these match the original design:
    // 30 gap / 50 strip / 20 gap / 50 row.
    final cardHeight = height ?? 150;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: cardHeight * 0.15,
        ),
        Container(
          color: Colors.black,
          height: cardHeight * 0.25,
          width: width,
        ),
        SizedBox(
          height: cardHeight * 0.10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                height: cardHeight * 0.25,
                color: Colors.grey,
              ),
            ),
            Flexible(
              child: SizedBox(
                height: cardHeight * 0.25,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    cvv ?? '',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ).merge(cvvTextStyle),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
