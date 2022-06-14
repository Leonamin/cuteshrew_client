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
        const SizedBox(
          width: 10.0,
        ),
        RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          text: TextSpan(
              text: title,
              recognizer: TapGestureRecognizer()
                ..onTap = onClick as GestureTapCallback?),
        ),
        const SizedBox(
          width: 10.0,
        ),
        const Icon(Icons.comment)
      ],
    );
  }
}
