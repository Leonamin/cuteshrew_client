import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';

// 게시글 내용 없이 커뮤니티와 유저 정보를 넣는다.
// 2022-12-25
// PostingEntity를 기본으로 두고 아래에 Preview를 두게 만들었다.
class PostingPreviewEntity extends PostingEntity {
  final UserEntity writer;
  final CommunityEntity ownCommunity;

  const PostingPreviewEntity({
    required int postId,
    required String title,
    required bool isLocked,
    required int publishedAt,
    required int updatedAt,
    required this.writer,
    required this.ownCommunity,
    required int commentCount,
  }) : super(
          postId: postId,
          title: title,
          isLocked: isLocked,
          publishedAt: publishedAt,
          updatedAt: updatedAt,
          commentCount: commentCount,
        );

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
