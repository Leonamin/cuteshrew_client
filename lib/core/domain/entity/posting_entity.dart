import 'package:equatable/equatable.dart';

// 게시글의 최소 정보만 정의한다.
// 2022-12-25
// 다른 엔티티를 참조하지 않도록 Community, User와 독립되게 만들었다.
abstract class PostingEntity extends Equatable {
  final int postId;
  final String title;
  final bool isLocked;
  final int publishedAt;
  final int updatedAt;
  final int commentCount;

  const PostingEntity({
    required this.postId,
    required this.title,
    required this.isLocked,
    required this.publishedAt,
    required this.updatedAt,
    required this.commentCount,
  });

  @override
  List<Object?> get props => [
        postId,
        title,
        isLocked,
        publishedAt,
        updatedAt,
        commentCount,
      ];
}
