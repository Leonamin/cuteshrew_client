import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';

// 게시글의 내용을 포함해서 자세한 정보를 제공한다.
// 2022-12-25
// 최대한 UserEntity와 CommunityEntity의 변경사항에 다른 게시글 엔티티가 영향이 없도록 추상클래스를 분리시켜 상속받는다.
class PostingDetailEntity extends PostingEntity {
  final String body;
  final UserEntity writer;
  final CommunityEntity ownCommunity;

  const PostingDetailEntity({
    required int postId,
    required String title,
    required this.body,
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
        body,
        isLocked,
        publishedAt,
        updatedAt,
        writer,
        ownCommunity,
        commentCount,
      ];
}
