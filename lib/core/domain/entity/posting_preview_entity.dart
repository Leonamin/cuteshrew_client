import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

// 게시글 내용 없이 메타 데이터만 필요로 하는 엔티티
class PostingPreviewEntity extends Equatable {
  final int postId;
  final String title;
  final bool isLocked;
  final int publishedAt;
  final int updatedAt;
  final UserEntity writer;
  final CommunityEntity ownCommunity;

  final int commentCount;

  const PostingPreviewEntity({
    required this.postId,
    required this.title,
    required this.isLocked,
    required this.publishedAt,
    required this.updatedAt,
    required this.writer,
    required this.ownCommunity,
    required this.commentCount,
  });

  @override
  List<Object?> get props => [
        postId,
        title,
        isLocked,
        publishedAt,
        updatedAt,
        writer,
        ownCommunity,
        commentCount,
      ];
}
