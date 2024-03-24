import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle h5 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle h6 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
  );
}

extension TextStylesFontExt on TextStyle {
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w800);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
  TextStyle get overline => copyWith(decoration: TextDecoration.overline);
  TextStyle get underlineDotted => copyWith(
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.dotted);
  TextStyle get underlineDashed => copyWith(
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.dashed);
  TextStyle get underlineWavy => copyWith(
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.wavy);
  TextStyle get lineThroughDotted => copyWith(
      decoration: TextDecoration.lineThrough,
      decorationStyle: TextDecorationStyle.dotted);
  TextStyle get lineThroughDashed => copyWith(
      decoration: TextDecoration.lineThrough,
      decorationStyle: TextDecorationStyle.dashed);
  TextStyle get lineThroughWavy => copyWith(
      decoration: TextDecoration.lineThrough,
      decorationStyle: TextDecorationStyle.wavy);
  TextStyle get overlineDotted => copyWith(
      decoration: TextDecoration.overline,
      decorationStyle: TextDecorationStyle.dotted);
  TextStyle get overlineDashed => copyWith(
      decoration: TextDecoration.overline,
      decorationStyle: TextDecorationStyle.dashed);
  TextStyle get overlineWavy => copyWith(
      decoration: TextDecoration.overline,
      decorationStyle: TextDecorationStyle.wavy);
}
