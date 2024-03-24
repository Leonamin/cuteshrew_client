class PostingSummary {
  final int id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isLocked;
  final int commentCount;

  final String shortContent;

  final int writerId;
  final String writerName;

  final int communityId;
  final String communityName;

  const PostingSummary({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.isLocked,
    required this.commentCount,
    required this.shortContent,
    required this.writerId,
    required this.writerName,
    required this.communityId,
    required this.communityName,
  });
}
