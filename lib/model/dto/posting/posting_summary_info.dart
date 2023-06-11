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
  }) : super(
          postId: postId,
          title: title,
          isLocked: isLocked,
          createdAt: createdAt,
          updatedAt: updatedAt,
          commentCount: commentCount,
          hits: hits,
        );
}
