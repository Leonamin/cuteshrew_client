part of '../posting_dto.dart';

class PostingCreateForm extends Equatable {
  final String title;
  final String body;
  final bool isLocked;
  final String? password;

  const PostingCreateForm({
    required this.title,
    required this.body,
    required this.isLocked,
    required this.password,
  });

  @override
  List<Object?> get props => [
        title,
        body,
        isLocked,
        password,
      ];
}
