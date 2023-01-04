import 'package:flutter/material.dart';

class UserPostingInfoItem extends StatelessWidget {
  final String? title;
  final String? datetime;
  final String? commentCount;
  final Function()? onItemPressed;
  final Function()? onItemLongPressed;
  final Function()? onCommentItemPressed;

  const UserPostingInfoItem({
    super.key,
    this.title,
    this.datetime,
    this.commentCount,
    this.onItemPressed,
    this.onItemLongPressed,
    this.onCommentItemPressed,
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
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
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
          TextButton(
            onPressed: onCommentItemPressed,
            style: TextButton.styleFrom(
                minimumSize: const Size(60, 60),
                backgroundColor: Colors.grey.withOpacity(0.2)),
            child: Text(
              commentCount ?? "0",
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
