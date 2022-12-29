import 'package:equatable/equatable.dart';

// 프레젠테이션 계층에서 사용할 게시글 데이터 기본 구조
abstract class PostingData extends Equatable {
  final int postId;
  final String title;
  final bool isLocked;
  final int publishedAt;
  final int updatedAt;
  final int commentCount;

  const PostingData({
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
