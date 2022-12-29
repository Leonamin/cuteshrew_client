import 'package:cuteshrew/presentation/widgets/common_widgets/clickable_text.dart';
import 'package:flutter/material.dart';

// 최대한 데이터적으로는 독립적으로 사용할 수 있게 하자
class PostingItem extends StatelessWidget {
  final String? title;
  final int? commentCount;
  final Function()? onClick;
  const PostingItem({
    Key? key,
    this.title,
    this.commentCount,
    required this.onClick,
  }) : super(key: key);

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
              text: title ?? "None",
              onClick: onClick,
            ),
          ),
        ),
        Center(
          child: Text(
            commentCountToString(commentCount ?? -1),
            style: TextStyle(color: Colors.blue[300]),
          ),
        ),
      ],
    );
  }
}
