class PostingDetail {
  final int id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isLocked;
  final int commentCount;

  final String content;

  final int writerId;
  final int communityId;

  const PostingDetail({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.isLocked,
    required this.commentCount,
    required this.content,
    required this.writerId,
    required this.communityId,
  });
}
