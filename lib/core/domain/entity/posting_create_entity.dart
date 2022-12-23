import 'package:equatable/equatable.dart';

// 게시글 작성 정보가 있는 엔티티
class PostingCreateEntity extends Equatable {
  final String title;
  final String body;
  final bool isLocked;
  final String? password;

  const PostingCreateEntity({
    required this.title,
    required this.body,
    required this.isLocked,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        body,
        isLocked,
        password,
      ];
}
