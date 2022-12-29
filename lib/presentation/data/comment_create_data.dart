import 'package:equatable/equatable.dart';

class CommentCreateData extends Equatable {
  final String comment;
  // 이하 나중에 만들것들
  final int? groupId;
  final int? commentClass;

  const CommentCreateData({
    required this.comment,
    this.groupId,
    this.commentClass,
  });
  @override
  List<Object?> get props => [
        comment,
        groupId,
        commentClass,
      ];
}
