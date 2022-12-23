import 'package:cuteshrew/core/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

// 게시글 전문이 들어가 있는 엔티티
class PostingEntity extends Equatable {
  final int postId;
  final String title;
  final String body;
  final bool isLocked;
  final int publishedAt;
  final int updatedAt;
  final UserEntity writer;
  final int commentCount;

  const PostingEntity({
    required this.postId,
    required this.title,
    required this.body,
    required this.isLocked,
    required this.publishedAt,
    required this.updatedAt,
    required this.writer,
    required this.commentCount,
  });

  @override
  List<Object?> get props => [
        postId,
        title,
        body,
        isLocked,
        publishedAt,
        updatedAt,
        writer,
        commentCount,
      ];
}
