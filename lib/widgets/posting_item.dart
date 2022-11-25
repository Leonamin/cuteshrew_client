import 'package:cuteshrew/widgets/clickable_text.dart';
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
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClickableText(
              text: title,
              onClick: onClick,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: const Icon(Icons.comment))
      ],
    );
  }
}
