part of '../posting_dto.dart';

class PostingSummaryInfo extends _BasePosting {
  const PostingSummaryInfo({
    required int postId,
    required String title,
    required bool isLocked,
    required int createdAt,
    required int updatedAt,
    required int commentCount,
    required int hits,
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

  final UserSummaryInfo writer;

  factory PostingSummaryInfo.empty() => PostingSummaryInfo(
        postId: -1,
        title: '',
        isLocked: false,
        createdAt: -1,
        updatedAt: -1,
        commentCount: -1,
        hits: -1,
        writer: UserSummaryInfo.empty(),
      );

  @override
  List<Object?> get props => [
        ...super.props,
        writer,
      ];
}
