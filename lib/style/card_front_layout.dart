import 'package:flutter/material.dart';

class CardFrontLayout {
  CardFrontLayout._();

  static Widget layout1 = Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Axis Bank",
              style: TextStyle(color: Colors.white, fontFamily: "MavenPro"),
            )


          ],
        )
      ],
    ),
  );
}