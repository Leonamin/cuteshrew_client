import 'package:cuteshrew/core/data/dto/remote/community_dto.dart';
import 'package:cuteshrew/data/remote/user/user_res.dart';
import 'package:json_annotation/json_annotation.dart';

part 'posting_res.g.dart';

@JsonSerializable()
class PostingRes {
  @JsonKey(name: 'id')
  final int postId;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'body')
  final String? body;
  @JsonKey(name: 'is_locked')
  final bool? isLocked;
  @JsonKey(name: 'published_at')
  final int? publishedAt;
  @JsonKey(name: 'updated_at')
  final int? updatedAt;
  @JsonKey(name: 'creator')
  final UserRes? writerInfo;
  @JsonKey(name: 'own_community')
  final CommunityDTO? ownCommunity;
  @JsonKey(name: 'comment_count')
  final int? commnetCount;

  const PostingRes({
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

  factory PostingRes.fromJson(Map<String, dynamic> json) =>
      _$PostingResFromJson(json);

  Map<String, dynamic> toJson() => _$PostingResToJson(this);
}
