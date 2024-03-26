import 'package:cuteshrew/0_foundation/ui/text_styles.dart';
import 'package:cuteshrew/1_model/entity/posting/posting_summary.dart';
import 'package:cuteshrew/3_view/0_component/badge/category_tag.dart';
import 'package:cuteshrew/3_view/0_component/badge/update_badge.dart';
import 'package:cuteshrew/3_view/0_component/circle_profile_widget.dart';
import 'package:cuteshrew/4_util/ext/shrew_datetime_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PostingCardWidget extends StatelessWidget {
  final String? userThumbnailUrl;
  final String userName;

  final String title;
  final String content;

  final DateTime createdAt;

  final String communityName;

  const PostingCardWidget({
    super.key,
    required this.userName,
    this.userThumbnailUrl,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.communityName,
  });

  factory PostingCardWidget.fromPostingSummary(
    PostingSummary postingSummary,
  ) {
    return PostingCardWidget(
      userName: postingSummary.writerName,
      title: postingSummary.title,
      content: postingSummary.shortContent,
      createdAt: postingSummary.createdAt,
      communityName: postingSummary.communityName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 유저 정보
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleProfileWidget(
              thumbUrl: userThumbnailUrl,
              size: CircleProfileWidget.small,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                userName,
                style: TextStyles.body2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              createdAt.toDotYMD(),
              style: TextStyles.body2,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SelectionArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: title,
                            style: TextStyles.h3,
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Html(
                      data: content,
                      style: {
                        "body": Style(
                          padding: HtmlPaddings.zero,
                          margin: Margins.zero,
                        )
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 32),
            _ThumbnailBox(
              thumbnailUrl: 'https://picsum.photos/80/56',
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CategoryTag(
              text: communityName,
              size: BadgeSize.small,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              background: BadgeBackground.light,
              borderRadius: 100,
            ),
          ],
        )
      ],
    );
  }
}

class _ThumbnailBox extends StatelessWidget {
  final String thumbnailUrl;
  final Size size;
  final double aspectRatio;

  static const smallScreenSize = Size(80, 56);
  static const largeScreenSize = Size(120, 120);

  static const smallScreenAspectRatio = 10 / 7;
  static const largeScreenAspectRatio = 1;

  const _ThumbnailBox({
    super.key,
    required this.thumbnailUrl,
    this.size = const Size(80, 56),
    this.aspectRatio = 10 / 7,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Image.network(
          thumbnailUrl,
          fit: BoxFit.fitWidth,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(Icons.error_outline),
          ),
        ),
      ),
    );
  }
}
