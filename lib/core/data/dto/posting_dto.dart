import 'package:cuteshrew/core/data/dto/community_dto.dart';
import 'package:cuteshrew/core/data/dto/user_dto.dart';

class PostingDTO {
  final int postId;
  final String? title;
  final String? body;
  final bool? isLocked;
  final int? publishedAt;
  final int? updatedAt;
  final UserDTO? writerInfo;
  final CommunityDTO? ownCommunity;
  final int? commnetCount;

  const PostingDTO({
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

  factory PostingDTO.fromJson(Map<String, dynamic> json) {
    return PostingDTO(
      postId: json['id'],
      title: json['title'],
      body: json['body'],
      isLocked: json['is_locked'],
      publishedAt: json['published_at'],
      updatedAt: json['updated_at'],
      writerInfo: UserDTO.fromJson(json['creator']),
      ownCommunity: CommunityDTO.fromJson(json['own_community']),
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
        'creator': writerInfo,
        'own_community': ownCommunity,
        'comment_count': commnetCount,
      };
}
