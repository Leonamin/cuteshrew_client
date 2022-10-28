import 'package:cuteshrew/models/user_info.dart';

class CommentDetail {
  int commentId;
  int userId;
  String comment;
  int createdAt;
  int postId;
  int commentClass;
  int order;
  int groupId;
  UserInfo userInfo;

  CommentDetail({
    required this.commentId,
    required this.userId,
    required this.comment,
    required this.createdAt,
    required this.postId,
    required this.commentClass,
    required this.order,
    required this.groupId,
    required this.userInfo,
  });

  factory CommentDetail.fromJson(Map<String, dynamic> json) {
    return CommentDetail(
        commentId: json['id'],
        userId: json['user_id'],
        comment: json['comment'],
        createdAt: json['created_at'],
        postId: json['post_id'],
        commentClass: json['comment_class'],
        order: json['order'],
        groupId: json['group_id'],
        userInfo: json['creator']);
  }
}
