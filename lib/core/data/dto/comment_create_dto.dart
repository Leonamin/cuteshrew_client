class CommentCreateDTO {
  final String comment;
  final int? groupId;
  final int? commentClass;

  const CommentCreateDTO({
    required this.comment,
    this.groupId,
    this.commentClass,
  });

  factory CommentCreateDTO.fromJson(Map<String, dynamic> json) {
    return CommentCreateDTO(
      comment: json['comment'],
      groupId: json['group_id'],
      commentClass: json['comment_class'],
    );
  }

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'group_id': groupId,
        'comment_class': commentClass,
      };
}
