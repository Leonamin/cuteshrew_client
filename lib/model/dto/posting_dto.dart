import 'package:cuteshrew/model/dto/user_dto.dart';
import 'package:equatable/equatable.dart';

part 'posting/posting_detail_info.dart';
part 'posting/posting_summary_info.dart';
part 'posting/posting_create_form.dart';

abstract class _BasePosting extends Equatable {
  final int postId;
  final String title;
  final bool isLocked;
  final int createdAt;
  final int updatedAt;
  final int commentCount;
  final int hits;

  const _BasePosting({
    required this.postId,
    required this.title,
    required this.isLocked,
    required this.createdAt,
    required this.updatedAt,
    required this.commentCount,
    required this.hits,
  });

  @override
  List<Object?> get props => [
        postId,
        title,
        isLocked,
        createdAt,
        updatedAt,
        commentCount,
        hits,
      ];
}
