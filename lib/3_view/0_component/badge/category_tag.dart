import 'package:cuteshrew/0_foundation/ui/color_palettes.dart';
import 'package:cuteshrew/0_foundation/ui/text_styles.dart';
import 'package:cuteshrew/3_view/0_component/badge/update_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryTag extends StatelessWidget {
  const CategoryTag({
    super.key,
    this.text = '',
    this.padding,
    this.borderRadius = 0,
    this.prefix,
    this.suffix,
    this.size = BadgeSize.small,
    this.color = BadgeColor.grey,
    this.background = BadgeBackground.empty,
  });

  final String text;
  final EdgeInsets? padding;
  final double borderRadius;
  final Widget? prefix;
  final Widget? suffix;
  final BadgeSize size;
  final BadgeColor color;
  final BadgeBackground background;

  Color get textColor {
    if (background.isFilled) return ColorPaletts.white;
    return color.textColor;
  }

  TextStyle? get _textStyle {
    return size.textStyle.copyWith(color: textColor);
  }

  EdgeInsets? get _padding {
    if (background.isEmpty) return null;
    if (padding != null) return padding;

    switch (size) {
      case BadgeSize.small:
        return const EdgeInsets.symmetric(horizontal: 4, vertical: 1);
      case BadgeSize.large:
        if (prefix == null && suffix == null) {
          return const EdgeInsets.symmetric(horizontal: 10, vertical: 2);
        }
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 2);
    }
  }

  BoxDecoration get _decoration {
    switch (background) {
      case BadgeBackground.empty:
        return const BoxDecoration();
      case BadgeBackground.light:
        return BoxDecoration(color: color.lightBackgroundColor);
      case BadgeBackground.filled:
        return BoxDecoration(color: color.filledBackgroundColor);
    }
  }

  CategoryTag copyWith({
    String? text,
    Widget? prefix,
    Widget? suffix,
    BadgeSize? size,
    BadgeColor? color,
    EdgeInsets? padding,
    BadgeBackground? background,
  }) =>
      CategoryTag(
        text: text ?? this.text,
        prefix: prefix ?? this.prefix,
        suffix: suffix ?? this.suffix,
        size: size ?? this.size,
        color: color ?? this.color,
        padding: padding ?? this.padding,
        background: background ?? this.background,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      decoration: _decoration.copyWith(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefix != null) ...[
            SizedBox(
              width: size.iconSize,
              height: size.iconSize,
              child: prefix!,
            ),
            const SizedBox(width: 2),
          ],
          Text(
            text,
            style: _textStyle,
          ),
          if (suffix != null) ...[
            const SizedBox(width: 2),
            SizedBox(
              width: size.iconSize,
              height: size.iconSize,
              child: suffix!,
            ),
          ],
        ],
      ),
    );
  }
}

enum BadgeBackground { empty, light, filled }

extension BadgeBackgroundExt on BadgeBackground {
  bool get isEmpty => this == BadgeBackground.empty;
  bool get isLight => this == BadgeBackground.light;
  bool get isFilled => this == BadgeBackground.filled;
}

extension BadgeSizeExt on BadgeSize {
  TextStyle get textStyle {
    switch (this) {
      case BadgeSize.small:
        return TextStyles.caption.medium;
      case BadgeSize.large:
        return TextStyles.caption.medium;
    }
  }

  double get iconSize {
    switch (this) {
      case BadgeSize.small:
        return 12;
      case BadgeSize.large:
        return 16;
    }
  }
}

enum BadgeColor { red, green, yellow, purple, grey, blue }

extension BadgeColorExt on BadgeColor {
  Color get textColor {
    switch (this) {
      case BadgeColor.red:
        return ColorPaletts.error4;
      case BadgeColor.green:
        return ColorPaletts.primary4;
      case BadgeColor.yellow:
        return ColorPaletts.warning4;
      case BadgeColor.purple:
        return ColorPaletts.primary4;
      case BadgeColor.grey:
        return ColorPaletts.grayscale7;
      case BadgeColor.blue:
        return ColorPaletts.primary4;
    }
  }

  Color get lightBackgroundColor {
    switch (this) {
      case BadgeColor.red:
        return ColorPaletts.error1;
      case BadgeColor.green:
        return ColorPaletts.primary1;
      case BadgeColor.yellow:
        return ColorPaletts.warning1;
      case BadgeColor.purple:
        return ColorPaletts.primary2;
      case BadgeColor.grey:
        return ColorPaletts.grayscale2;
      case BadgeColor.blue:
        return ColorPaletts.primary2;
    }
  }

  Color get filledBackgroundColor {
    switch (this) {
      case BadgeColor.red:
        return ColorPaletts.error4;
      case BadgeColor.green:
        return ColorPaletts.primary4;
      case BadgeColor.yellow:
        return ColorPaletts.warning4;
      case BadgeColor.purple:
        return ColorPaletts.primary4;
      case BadgeColor.grey:
        return ColorPaletts.grayscale8;
      case BadgeColor.blue:
        return ColorPaletts.primary4;
    }
  }
}

extension CategoryTagExt on CategoryTag {
  CategoryTag get small => copyWith(size: BadgeSize.small);
  CategoryTag get large => copyWith(size: BadgeSize.large);

  CategoryTag get empty => copyWith(background: BadgeBackground.empty);
  CategoryTag get light => copyWith(background: BadgeBackground.light);
  CategoryTag get filled => copyWith(background: BadgeBackground.filled);

  CategoryTag withSvgPrefix(String svgPath) => copyWith(
        prefix: SvgPicture.asset(
          svgPath,
          color: textColor,
        ),
      );

  CategoryTag withSvgSuffix(String svgPath) => copyWith(
        suffix: SvgPicture.asset(
          svgPath,
          color: textColor,
        ),
      );
}
