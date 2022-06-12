import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CommunityTitle extends StatelessWidget {
  final String title;
  final Function onClick;
  const CommunityTitle({Key? key, required this.title, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
        style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 0.9),
        toolbarOptions: const ToolbarOptions(
            copy: true, selectAll: true, cut: false, paste: false),
        maxLines: 1,
        TextSpan(
            text: title,
            recognizer: TapGestureRecognizer()
              ..onTap = onClick as GestureTapCallback?));
  }
}
