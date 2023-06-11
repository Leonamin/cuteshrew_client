part of '../comment_dto.dart';

class CommentDetailInfo extends _BaseComment {
  const CommentDetailInfo({
    required int commentId,
    required int writerId,
    required int commentClass,
    required int createdAt,
    required int groupId,
    required int order,
    required int postId,
    required this.comment,
    required this.parentPosting,
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

  final String comment;
  final PostingSummaryInfo parentPosting;
  final UserSummaryInfo writer;

  @override
  List<Object?> get props => [
        ...super.props,
        comment,
        parentPosting,
        writer,
      ];
}
