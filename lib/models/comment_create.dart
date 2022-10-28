class CommentCreate {
  String comment;

  CommentCreate({required this.comment});

  Map toJson() {
    return {'comment': comment};
  }
}
