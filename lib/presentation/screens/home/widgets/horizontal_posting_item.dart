import 'package:cuteshrew/presentation/config/constants/color.dart';
import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/presentation/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HorizontalPostingItem extends StatelessWidget {
  final String? title;
  final String? writerName;
  final String? commentCount;
  final int? publishedAt;
  final Function()? onUserPressed;
  final Function()? onPostingPressed;
  const HorizontalPostingItem({
    super.key,
    this.title,
    this.writerName,
    this.commentCount,
    this.publishedAt,
    this.onUserPressed,
    this.onPostingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Row(
            children: [
              // TODO 유저 프로필
              GestureDetector(
                onTap: onUserPressed,
                child: CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Colors.white,
                  foregroundColor: communitySecondaryColor,
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              // 게시글 정보
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${title ?? "제목 없음"}\n",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                        recognizer: TapGestureRecognizer()
                          ..onTap = onPostingPressed,
                      ),
                      TextSpan(
                        text: "${writerName ?? "Dantto"}    ",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = onUserPressed,
                      ),
                      if (!ResponsiveWidget.isLargeScreen(context))
                        const TextSpan(text: "\n"),
                      TextSpan(
                        text: "${Utils.formatTimeStamp(publishedAt ?? 0)}    ",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: communitySecondaryTextColor),
                      ),
                    ],
                  ),
                ),
              )
              /*
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      title ?? "제목 없음",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          writerName ?? "ㅇㅇ",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Utils.formatTimeStamp(publishedAt ?? 0),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(),
                        ),
                      ],
                    ),
                  )
                ],
              )
              */
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commentCount ?? "0",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    "댓글",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: communitySecondaryTextColor),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO 조회수
                  Text(
                    "0",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    "조회수",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: communitySecondaryTextColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
