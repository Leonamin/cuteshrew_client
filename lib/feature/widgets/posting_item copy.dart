import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/feature/widgets/clickable_text.dart';
import 'package:flutter/material.dart';

class PostingItem extends StatelessWidget {
  final PostingEntity posting;
  final Function onClick;
  const PostingItem({Key? key, required this.posting, required this.onClick})
      : super(key: key);

  commentCountToString(int count) {
    if (count >= 100) {
      return "99+";
    } else {
      return count.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClickableText(
              text: posting.title,
              onClick: onClick,
            ),
          ),
        ),
        Center(
          child: Text(
            commentCountToString(posting.commentCount),
            style: TextStyle(color: Colors.blue[300]),
          ),
        ),
      ],
    );
  }
}
