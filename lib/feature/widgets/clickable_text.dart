import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final Function? onClick;

  const ClickableText(
      {Key? key,
      required this.text,
      this.size,
      this.color,
      this.weight,
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
          text: text,
          recognizer: TapGestureRecognizer()
            ..onTap = onClick as GestureTapCallback?),
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: size ?? 16,
          color: color ?? Colors.black,
          fontWeight: weight ?? FontWeight.normal),
      maxLines: 1,
      toolbarOptions: const ToolbarOptions(
          copy: true, selectAll: true, cut: false, paste: false),
    );
  }
}
