# Draft closing comments for open GitHub issues

Copy-paste ready. Written for the maintainer's voice. Delete this file after posting.

---

## #29 — "Unable to load asset: …/master_card.png"

> Thanks for the report. I audited the full asset pipeline and couldn't reproduce this:
>
> - All card provider images (including `master_card.png`) are present in the repository and declared under `assets:` in `pubspec.yaml`.
> - I downloaded the published `awesome_card 1.1.7` archive from pub.dev and verified it contains `images/card_provider/master_card.png` and every other icon.
> - An automated test now loads all 10 package assets from a consumer app via `rootBundle.load('packages/awesome_card/…')` — all pass. It runs in CI so a regression would be caught.
>
> The two most common causes of this error on the consumer side:
> 1. Referencing the image from your own code without the package parameter — it must be `Image.asset('images/card_provider/master_card.png', package: 'awesome_card')`.
> 2. A stale build after adding the dependency — run `flutter clean && flutter pub get` and rebuild.
>
> Closing as not reproducible. If you still hit this on the latest version, please reopen with a minimal repro and your `flutter doctor -v` output.

---

## #11 — "Could not resolve org.antlr:antlr4:4.5.3"

> This failure came from the *example app's* Android build, not the library itself. The example's Gradle setup at the time resolved dependencies from JCenter, which shut down in 2021 — that's the read-timeout in your log.
>
> Fixed in 1.2.0: the example's Android project has been modernized to the declarative Flutter Gradle plugin with AGP 8.11.1, Kotlin 2.2.20, Gradle 8.14, and `mavenCentral()` instead of `jcenter()`. A fresh clone now builds with a current Flutter SDK (3.10+).
>
> Closing — please reopen if the example still fails to build for you on the latest `dev`.

---

## #4 — "Custom card number and holder name text style"

> Finally shipped in 1.2.0 🎉
>
> `CreditCard` now accepts per-field text style overrides:
>
> ```dart
> CreditCard(
>   // ...
>   bankNameTextStyle: TextStyle(fontSize: 20),
>   cardNumberTextStyle: TextStyle(fontSize: 24, letterSpacing: 2),
>   cardExpiryTextStyle: TextStyle(fontStyle: FontStyle.italic),
>   cardHolderNameTextStyle: TextStyle(fontWeight: FontWeight.bold),
>   cvvTextStyle: TextStyle(color: Colors.red),
> )
> ```
>
> Each style is **merged over the default**, so a partial override (e.g. only `fontSize`) keeps the default font, weight, and color for everything else. Colors still default to `frontTextColor`/`backTextColor`.
>
> @CharlyIglesias for centering the card number (or any bigger layout change), pass your own widget via the `frontLayout` parameter — it replaces the built-in front layout entirely.
>
> Closing as completed.
