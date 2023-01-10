import 'package:cuteshrew/core/data/dto/remote/comment_dto.dart';
import 'package:cuteshrew/core/data/dto/remote/user_dto.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/data/mapper/user_mapper.dart';
import 'package:cuteshrew/core/domain/entity/comment_preview_entity.dart';

class CommentPreviewMapper extends Mapper<CommentDTO, CommentPreviewEntity> {
  @override
  CommentPreviewEntity map(CommentDTO object) {
    UserDetailMapper userMapper = UserDetailMapper();

    /*
      기본 처리
      writerId: 1번 유저
      commentClass: 1번 계층
      createdAt: 시간 0
      groupId: 아이디와 같게 해서 같은 그룹으로
      order: 없으면 무조건 첫번째
      postId: 1번 게시글
      writer: 그냥 nickname, email로
    */
    return CommentPreviewEntity(
        commentId: object.commentId,
        writerId: object.writerId ?? 1,
        commentClass: object.commentClass ?? 1,
        createdAt: object.createdAt ?? 0,
        groupId: object.groupId ?? object.commentId,
        order: object.order ?? 1,
        postId: object.postId ?? 1,
        writer: userMapper.map(
          object.writerInfo ??
              const UserDTO(nickname: "nickname", email: "email"),
        ));
  }
}
