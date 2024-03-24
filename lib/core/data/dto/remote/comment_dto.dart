import 'package:cuteshrew/2_data/remote/posting/posting_summary_res.dart';
import 'package:cuteshrew/2_data/remote/user/user_summary_res.dart';

class CommentDTO {
  final int commentId;
  final int? writerId;
  final String? comment;
  final int? createdAt;
  final int? postId;
  final int? commentClass;
  final int? order;
  final int? groupId;
  final UserSummaryRes? writerInfo;
  final PostingSummaryRes? posting;

  const CommentDTO({
    required this.commentId,
    this.writerId,
    this.comment,
    this.createdAt,
    this.postId,
    this.commentClass,
    this.order,
    this.groupId,
    this.writerInfo,
    this.posting,
  });

  factory CommentDTO.fromJson(Map<String, dynamic> json) {
    return CommentDTO(
      commentId: json['id'],
      writerId: json['user_id'],
      comment: json['comment'],
      createdAt: json['created_at'],
      postId: json['post_id'],
      commentClass: json['comment_class'],
      order: json['order'],
      groupId: json['group_id'],
      writerInfo: (json['creator'] != null)
          ? UserSummaryRes.fromJson(json['creator'])
          : null,
      posting: (json['posting'] != null)
          ? PostingSummaryRes.fromJson(json['posting'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': commentId,
        'user_id': writerId,
        'comment': comment,
        'created_at': createdAt,
        'post_id': postId,
        'comment_class': commentClass,
        'order': order,
        'group_id': groupId,
        'creator': writerInfo?.toJson(),
        'posting': posting?.toJson(),
      };
}
