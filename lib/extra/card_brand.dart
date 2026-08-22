import 'package:flutter/widgets.dart';

/// A custom card brand that can be registered on `CreditCard.customBrands`
/// to detect brands the package doesn't ship built-in (e.g. Troy, Mir,
/// Verve, or a store card).
///
/// Custom brands are matched against the card number (spaces ignored) only
/// when no explicit `cardType` is provided, and they take priority over the
/// built-in brand detection.
class CardBrand {
  /// Identifier for this brand, e.g. `'troy'`. Not shown on the card.
  final String name;

  /// Widget rendered in the card's brand-icon slot when [pattern] matches.
  final Widget icon;

  /// Pattern tested against the card number with spaces removed.
  final RegExp pattern;

  /// Optional number mask shown while the card number is empty,
  /// e.g. `'XXXX XXXX XXXX XXXX'`. Falls back to the default mask when null.
  final String? mask;

  CardBrand({
    required this.name,
    required this.icon,
    required this.pattern,
    this.mask,
  });
}
