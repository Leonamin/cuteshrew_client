part of '../posting_dto.dart';

class PostingDetailInfo extends _BasePosting {
  const PostingDetailInfo({
    required int postId,
    required String title,
    required bool isLocked,
    required int createdAt,
    required int updatedAt,
    required int commentCount,
    required int hits,
    required this.body,
    required this.writer,
  }) : super(
          postId: postId,
          title: title,
          isLocked: isLocked,
          createdAt: createdAt,
          updatedAt: updatedAt,
          commentCount: commentCount,
          hits: hits,
        );

  final String body;
  final UserSummaryInfo writer;

  @override
  List<Object?> get props => [
        ...super.props,
        body,
        writer,
      ];
}
