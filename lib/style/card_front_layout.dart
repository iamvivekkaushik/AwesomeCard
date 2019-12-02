import 'package:flutter/material.dart';

class CardFrontLayout {
  String bankName;
  String cardNumber;
  String cardExpiry;
  String cardHolderName;
  Widget cardTypeIcon;
  double cardWidth;
  double cardHeight;

  CardFrontLayout(
      {this.bankName = "",
      this.cardNumber = "",
      this.cardExpiry = "",
      this.cardHolderName = "",
      this.cardTypeIcon,
      this.cardWidth = 0,
      this.cardHeight = 0});

  Widget layout1() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: new Image.asset(
                    'images/contactless_icon.png',
                    fit: BoxFit.fitHeight,
                    width: 30.0,
                    height: 30.0,
                    color: Colors.white,
                    package: 'awesome_card',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: cardWidth,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  cardNumber,
                  style: TextStyle(
                      package: 'awesome_card',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: "MavenPro",
                      fontSize: 22),
                )),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Exp. Date",
                        style: TextStyle(
                            package: 'awesome_card',
                            color: Colors.white,
                            fontFamily: "MavenPro",
                            fontSize: 15),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        cardExpiry,
                        style: TextStyle(
                            package: 'awesome_card',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "MavenPro",
                            fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    cardHolderName,
                    style: TextStyle(
                        package: 'awesome_card',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "MavenPro",
                        fontSize: 17),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: cardTypeIcon,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
