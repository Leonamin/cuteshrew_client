import 'package:cuteshrew/1_model/entity/posting/posting_summary.dart';
import 'package:cuteshrew/2_data/remote/community/community_summary_res.dart';
import 'package:cuteshrew/2_data/remote/user/user_summary_res.dart';
import 'package:cuteshrew/4_util/ext/int_ext.dart';

class PostingSummaryRes {
  final int postId;
  final String? title;
  final String? body;
  final bool? isLocked;
  final int? publishedAt;
  final int? updatedAt;
  final UserSummaryRes? writerInfo;
  final CommunitySummaryRes? ownCommunity;
  final int? commnetCount;

  const PostingSummaryRes({
    required this.postId,
    this.title,
    this.body,
    this.isLocked,
    this.publishedAt,
    this.updatedAt,
    this.writerInfo,
    this.ownCommunity,
    this.commnetCount,
  });

  factory PostingSummaryRes.fromJson(Map<String, dynamic> json) {
    return PostingSummaryRes(
      postId: json['id'],
      title: json['title'],
      body: json['body'],
      isLocked: json['is_locked'],
      publishedAt: json['published_at'],
      updatedAt: json['updated_at'],
      writerInfo: (json['creator'] != null)
          ? UserSummaryRes.fromJson(json['creator'])
          : null,
      ownCommunity: (json['own_community'] != null)
          ? CommunitySummaryRes.fromJson(json['own_community'])
          : null,
      commnetCount: json['comment_count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': postId,
        'title': title,
        'body': body,
        'is_locked': isLocked,
        'published_at': publishedAt,
        'updated_at': updatedAt,
        'creator': writerInfo?.toJson(),
        'own_community': ownCommunity?.toJson(),
        'comment_count': commnetCount,
      };
}

extension PostingSummaryResExt on PostingSummaryRes {
  PostingSummary toEntity() => PostingSummary(
        id: postId,
        title: title ?? '',
        shortContent: body ?? '',
        isLocked: isLocked ?? false,
        createdAt: publishedAt?.toDateTime() ?? DateTime.now(),
        updatedAt: updatedAt?.toDateTime() ?? DateTime.now(),
        writerId: 1,
        writerName: writerInfo?.nickname ?? '',
        communityId: ownCommunity?.id ?? 1,
        communityName: ownCommunity?.communityName ?? '',
        commentCount: commnetCount ?? 0,
      );
}
