import 'package:flutter/material.dart';

class UserCommentInfoItem extends StatelessWidget {
  final String? title;
  final String? comment;
  final String? datetime;
  final Function()? onItemPressed;
  final Function()? onItemLongPressed;
  const UserCommentInfoItem({
    super.key,
    this.title,
    this.comment,
    this.datetime,
    this.onItemPressed,
    this.onItemLongPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: InkWell(
              onTap: onItemPressed,
              onLongPress: onItemLongPressed,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      comment ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // TODO 게시글 시간은 어떻게 표현하면 좋을까
                    // 댓글 시간
                    Text(
                      datetime ?? "",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8), fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
