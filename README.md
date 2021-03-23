<a href="https://github.com/iamvivekkaushik/AwesomeCard">
<img align="left" src="https://raw.githubusercontent.com/iamvivekkaushik/AwesomeCard/master/screenshot/card.gif" width="400" height="250" /></a>

<p><h2 align="left">Awesome Card</h2></p>

<h4>A flutter package to create a Credit Card widget in your application.</h4>


___


<p><h6>Stay tuned for the latest updates:</h6>
<a href="https://github.com/iamvivekkaushik" >
<img src="https://raw.githubusercontent.com/iamvivekkaushik/AwesomeCard/master/screenshot/github.png" width="220" height="40"></a></p>

</br>

[![Pub](https://img.shields.io/pub/v/awesome_card)](https://pub.dev/packages/awesome_card/versions/1.1.0)
[![Twitter](https://img.shields.io/badge/Twitter-@iamvivekkaushik-blue.svg?style=flat)](https://twitter.com/iamvivekkaushik)

## 📱Screenshots
<p align="center">
<img src="https://raw.githubusercontent.com/iamvivekkaushik/AwesomeCard/master/screenshot/front.png" width="300" height="630"/>
<img src="https://raw.githubusercontent.com/iamvivekkaushik/AwesomeCard/master/screenshot/back.png" width="300" height="630"/>
</p>
<br>

## ⚙️ Installation

Import the following package in your dart file

```dart
import 'package:awesome_card/awesome_card.dart';
```

## 👨‍💻 Usage

Use the `Awesome Card` Widget

```dart
CreditCard(
    cardNumber: "5450 7879 4864 7854",
    cardExpiry: "10/25",
    cardHolderName: "Card Holder",
    cvv: "456",
    bankName: "Axis Bank",
    cardType: CardType.masterCard, // Optional if you want to override Card Type
    showBackSide: false,
    frontBackground: CardBackgrounds.black,
    backBackground: CardBackgrounds.white,
    showShadow: true,
    textExpDate: 'Exp. Date',
    textName: 'Name',
    textExpiry: 'MM/YY'
),
```

For more detail on usage, check out the example provided.


## 🙍🏻‍♂️ Author

* [Vivek Kaushik](http://github.com/iamvivekkaushik/)


## 📄 License

Awesome Card is released under the MIT license.
See [LICENSE](./LICENSE) for details.
