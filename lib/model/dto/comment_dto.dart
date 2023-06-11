import 'package:cuteshrew/model/dto/posting_dto.dart';
import 'package:cuteshrew/model/dto/user_dto.dart';
import 'package:equatable/equatable.dart';

part 'comment/comment_detail_info.dart';
part 'comment/comment_summary_info.dart';
part 'comment/comment_create_form.dart';

abstract class _BaseComment extends Equatable {
  const _BaseComment({
    required this.commentId,
    required this.writerId,
    required this.commentClass,
    required this.createdAt,
    required this.groupId,
    required this.order,
    required this.postId,
  });

  final int commentId;
  final int writerId;
  final int createdAt;
  final int postId;
  final int commentClass;
  final int order;
  final int groupId;

  @override
  List<Object?> get props => [
        commentId,
        writerId,
        commentClass,
        createdAt,
        groupId,
        order,
        postId,
      ];
}
