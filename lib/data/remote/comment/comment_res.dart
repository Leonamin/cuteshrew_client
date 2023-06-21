import 'package:cuteshrew/data/remote/posting/posting_res.dart';
import 'package:cuteshrew/data/remote/user/user_res.dart';
import 'package:cuteshrew/model/dto/comment_dto.dart';
import 'package:cuteshrew/model/dto/posting_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_res.g.dart';

@JsonSerializable()
class CommentRes {
  @JsonKey(name: 'id')
  final int commentId;
  @JsonKey(name: 'user_id')
  final int? writerId;
  @JsonKey(name: 'comment')
  final String? comment;
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @JsonKey(name: 'post_id')
  final int? postId;
  @JsonKey(name: 'comment_class')
  final int? commentClass;
  @JsonKey(name: 'order')
  final int? order;
  @JsonKey(name: 'group_id')
  final int? groupId;
  @JsonKey(name: 'creator')
  final UserRes writerInfo;
  @JsonKey(name: 'posting')
  final PostingRes? posting;

  const CommentRes({
    required this.commentId,
    this.writerId,
    this.comment,
    this.createdAt,
    this.postId,
    this.commentClass,
    this.order,
    this.groupId,
    required this.writerInfo,
    this.posting,
  });

  factory CommentRes.fromJson(Map<String, dynamic> json) =>
      _$CommentResFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResToJson(this);
}

extension CommentResX on CommentRes {
  CommentSummaryInfo toSummaryInfo() => CommentSummaryInfo(
        commentId: commentId,
        writerId: writerId ?? -1,
        commentClass: commentClass ?? -1,
        createdAt: createdAt ?? -1,
        groupId: groupId ?? -1,
        order: order ?? -1,
        postId: postId ?? -1,
        writer: writerInfo.toSummaryInfo(),
      );

  CommentDetailInfo toDetailInfo() => CommentDetailInfo(
        commentId: commentId,
        comment: comment ?? '',
        writerId: writerId ?? -1,
        commentClass: commentClass ?? -1,
        createdAt: createdAt ?? -1,
        groupId: groupId ?? -1,
        order: order ?? -1,
        postId: postId ?? -1,
        writer: writerInfo.toSummaryInfo(),
        parentPosting: posting?.toSummaryInfo() ?? PostingSummaryInfo.empty(),
      );
}