import 'package:cuteshrew/0_foundation/ui/color_palettes.dart';
import 'package:cuteshrew/0_foundation/ui/text_styles.dart';
import 'package:flutter/material.dart';

class UpdateBadge extends StatelessWidget {
  const UpdateBadge({
    super.key,
    this.color,
    this.size = BadgeSize.small,
    this.text = '',
    this.textStyle,
    this.padding,
    this.boxShape = BoxShape.circle,
    this.borderRadius,
  });

  final Color? color;
  final BadgeSize size;
  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final BoxShape boxShape;
  final double? borderRadius;

  UpdateBadge copyWith({
    Color? color,
    BadgeSize? size,
    String? text,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    BoxShape? boxShape,
    double? borderRadius,
  }) =>
      UpdateBadge(
        color: color ?? this.color,
        size: size ?? this.size,
        text: text ?? this.text,
        textStyle: textStyle ?? this.textStyle,
        padding: padding ?? this.padding,
        boxShape: boxShape ?? this.boxShape,
        borderRadius: borderRadius ?? this.borderRadius,
      );

  double? get _size => text.isEmpty ? size.legnth : null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      padding: padding,
      decoration: BoxDecoration(
        shape: boxShape,
        color: color,
        borderRadius: boxShape == BoxShape.circle
            ? null
            : BorderRadius.all(
                Radius.circular(borderRadius ?? 0),
              ),
      ),
      child: Text(text, style: textStyle),
    );
  }
}

enum BadgeSize { small, large }

extension BadgeSizeExt on BadgeSize {
  double get legnth {
    switch (this) {
      case BadgeSize.small:
        return 5;
      case BadgeSize.large:
        return 12;
    }
  }

  EdgeInsetsGeometry get paddingNew {
    switch (this) {
      case BadgeSize.small:
        return const EdgeInsets.all(4);
      case BadgeSize.large:
        return const EdgeInsets.all(6);
    }
  }

  EdgeInsetsGeometry get paddingCount {
    switch (this) {
      case BadgeSize.small:
        return const EdgeInsets.symmetric(horizontal: 4, vertical: 1);
      case BadgeSize.large:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 2);
    }
  }
}

extension UpdateBadgeExtension on UpdateBadge {
  UpdateBadge get red => copyWith(color: ColorPaletts.error4);
  UpdateBadge get green => copyWith(color: ColorPaletts.primary4);
  UpdateBadge get yellow => copyWith(color: ColorPaletts.warning4);

  UpdateBadge get small => copyWith(
        size: BadgeSize.small,
        textStyle: TextStyles.caption.medium,
      );
  UpdateBadge get large => copyWith(
        size: BadgeSize.large,
        textStyle: TextStyles.caption.medium,
      );

  UpdateBadge get new$ => copyWith(
        text: 'N',
        padding: size.paddingNew,
        boxShape: BoxShape.circle,
      );

  String getCountStr(int count) => count > 99 ? '99+' : count.toString();
  bool is1Digit(int count) => 0 < count && count < 10;
  UpdateBadge count(int count) => copyWith(
        text: getCountStr(count),
        padding: is1Digit(count) ? size.paddingNew : size.paddingCount,
        boxShape: is1Digit(count) ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: 100,
      );
}
