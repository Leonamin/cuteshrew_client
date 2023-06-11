part of '../comment_dto.dart';

class CommentSummaryInfo extends _BaseComment {
  final UserSummaryInfo writer;

  const CommentSummaryInfo({
    required int commentId,
    required int writerId,
    required int commentClass,
    required int createdAt,
    required int groupId,
    required int order,
    required int postId,
    required this.writer,
  }) : super(
          commentId: commentId,
          writerId: writerId,
          commentClass: commentClass,
          createdAt: createdAt,
          groupId: groupId,
          order: order,
          postId: postId,
        );
  @override
  List<Object?> get props => [
        ...super.props,
        writer,
      ];
}
