import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PostingItem extends StatelessWidget {
  final String title;
  final Function onClick;
  const PostingItem({Key? key, required this.title, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SelectableText.rich(
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
            toolbarOptions: const ToolbarOptions(
                copy: true, selectAll: true, cut: false, paste: false),
            maxLines: 1,
            TextSpan(
                text: title,
                recognizer: TapGestureRecognizer()
                  ..onTap = onClick as GestureTapCallback?)),
        Flexible(child: Icon(Icons.comment)),
      ],
    );
  }
}
