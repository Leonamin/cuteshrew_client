import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/user_info.dart';

class PostDetail {
  int postId;
  String title;
  String body;
  bool isLocked;
  int publishedAt;
  int updatedAt;
  UserInfo userInfo;
  CommunityPreview ownCommunity;

  PostDetail({
    required this.postId,
    required this.title,
    required this.body,
    required this.isLocked,
    required this.publishedAt,
    required this.updatedAt,
    required this.userInfo,
    required this.ownCommunity,
  });

  factory PostDetail.fromJson(Map<String, dynamic> json) {
    return PostDetail(
        postId: json['id'],
        title: json['title'],
        body: json['body'],
        isLocked: json['is_locked'],
        publishedAt: json['published_at'],
        updatedAt: json['updated_at'],
        userInfo: UserInfo.fromJson(json['creator']),
        ownCommunity: CommunityPreview.fromJson(json['own_community']));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostDetail &&
          postId == other.postId &&
          title == other.title &&
          body == other.body &&
          isLocked == other.isLocked &&
          publishedAt == other.publishedAt &&
          updatedAt == other.updatedAt &&
          userInfo == other.userInfo);

  @override
  int get hashCode => Object.hash(
      postId, title, body, isLocked, publishedAt, updatedAt, userInfo);
}
