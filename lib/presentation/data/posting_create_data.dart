// 게시글 작성 정보가 있는 엔티티
import 'package:equatable/equatable.dart';

class PostingCreateData extends Equatable {
  final String title;
  final String body;
  final bool isLocked;
  final String? password;

  const PostingCreateData({
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
