import 'package:equatable/equatable.dart';

// 댓글 생성에 사용하는 엔티티
class CommentCreateEntity extends Equatable {
  final String comment;

  const CommentCreateEntity({required this.comment});
  @override
  List<Object?> get props => [];
}
