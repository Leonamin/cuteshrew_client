class PostDetail {
  int postId;
  String title;
  String body;
  bool isLocked;

  PostDetail(
      {required this.postId,
      required this.title,
      required this.body,
      required this.isLocked});

  factory PostDetail.fromJson(Map<String, dynamic> json) {
    return PostDetail(
        postId: json['id'],
        title: json['title'],
        body: json['body'],
        isLocked: json['is_locked']);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostDetail &&
          postId == other.postId &&
          title == other.title &&
          body == other.body &&
          isLocked == other.isLocked);

  @override
  int get hashCode => Object.hash(postId, title, body, isLocked);
}
