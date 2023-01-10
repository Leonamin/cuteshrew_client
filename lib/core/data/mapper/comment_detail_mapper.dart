import 'package:cuteshrew/core/data/dto/remote/comment_dto.dart';
import 'package:cuteshrew/core/data/dto/remote/user_dto.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/data/mapper/posting_preview_mapper.dart';
import 'package:cuteshrew/core/data/mapper/user_mapper.dart';
import 'package:cuteshrew/core/domain/entity/comment_detail_entity.dart';
import 'package:cuteshrew/core/domain/entity/community_preview_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_preview_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_preview_entity.dart';

class CommentDetailMapper extends Mapper<CommentDTO, CommentDetailEntity> {
  @override
  CommentDetailEntity map(CommentDTO object) {
    PostingPreviewMapper postingPreviewMapper = PostingPreviewMapper();
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
    return CommentDetailEntity(
      commentId: object.commentId,
      comment: object.comment ?? "",
      writerId: object.writerId ?? 1,
      commentClass: object.commentClass ?? 1,
      createdAt: object.createdAt ?? 0,
      groupId: object.groupId ?? object.commentId,
      order: object.order ?? 1,
      postId: object.postId ?? 1,
      parentPosting: (object.posting != null)
          ? postingPreviewMapper.map(object.posting!)
          : const PostingPreviewEntity(
              postId: 1,
              title: "",
              commentCount: 0,
              isLocked: false,
              publishedAt: 0,
              updatedAt: 0,
              writer: UserPreviewEntity(
                name: "unknown",
                email: "",
              ),
              ownCommunity: CommunityPreviewEntity(
                  communityName: "None",
                  communityShowName: "None",
                  postingCount: 0,
                  postings: [])),
      writer: userMapper.map(
        object.writerInfo ??
            const UserDTO(nickname: "nickname", email: "email"),
      ),
    );
  }
}
