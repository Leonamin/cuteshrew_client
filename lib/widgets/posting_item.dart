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
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClickableText(
              text: title,
              onClick: onClick,
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(right: 10.0),
            child: const Icon(Icons.comment))
      ],
    );
  }
}
