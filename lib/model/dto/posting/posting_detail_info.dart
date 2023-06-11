part of '../posting_dto.dart';

class PostingDetailInfo extends _BasePosting {
  final String body;

  const PostingDetailInfo({
    required int postId,
    required String title,
    required bool isLocked,
    required int createdAt,
    required int updatedAt,
    required int commentCount,
    required int hits,
    required this.body,
  }) : super(
          postId: postId,
          title: title,
          isLocked: isLocked,
          createdAt: createdAt,
          updatedAt: updatedAt,
          commentCount: commentCount,
          hits: hits,
        );

  @override
  List<Object?> get props => [
        ...super.props,
        body,
      ];
}
