part of '../comment_dto.dart';

class CommentCreateForm extends Equatable {
  final String comment;

  const CommentCreateForm({required this.comment});
  @override
  List<Object?> get props => [
        comment,
      ];
}
