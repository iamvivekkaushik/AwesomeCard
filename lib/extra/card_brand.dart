import 'dart:core';
import 'package:meta/meta.dart';

class CardBrand {
  final String name;
  final Object icon;
  final RegExp regex;

  CardBrand({@required this.name, @required this.icon, @required this.regex});
  
}