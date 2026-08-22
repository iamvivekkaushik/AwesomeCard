## [1.2.0] - 22/08/2026

* BREAKING: Minimum SDK is now Dart 3 / Flutter 3.10
* Fixed crash when neither cardNumber nor cardType is provided
* Fixed card type detection: RuPay (6521/6522) and Elo BINs were misclassified as Discover/Visa
* Fixed literal "null" shown on the card back when cvv is not provided
* Fixed RenderFlex overflows on narrow cards (front and back)
* `CardBackgrounds.custom` parameter is now typed as `int` (was dynamic, crashed at runtime on wrong type)
* Card type detection regexes are compiled once instead of on every rebuild
* Added text style customization: `bankNameTextStyle`, `cardNumberTextStyle`, `cardExpiryTextStyle`, `cardHolderNameTextStyle`, `cvvTextStyle` (#4)
* Modernized the example's Android project: declarative Flutter Gradle plugin, AGP 8.11.1, Kotlin 2.2.20, Gradle 8.14, mavenCentral instead of the dead jcenter (#11)
* Added a regression test suite; fixed the stale example test
* Updated CI publish workflow to current GitHub Actions and pub commands

## [1.1.7] - 27/01/2022

* Fixed overflow issue with customer name

## [1.1.6] - 14/11/2021

* Customize horizontal margin
* Fixed pixel overflow
* Customize card mask
* Custom card color helper method

## [1.1.5] - 23/03/2021

* Migrated to Null Safety
* Fixed issue with Card Transformation on flutter web
* Added option to override text label (Temporary)
* Added Elo Cards

## [1.1.0] - 24/01/2020

* Added Option to override Card Provider Icon

## [1.0.0+1] - 8/12/2019

* Fixed Readme

## [1.0.0] - 8/12/2019

* First release of the package
