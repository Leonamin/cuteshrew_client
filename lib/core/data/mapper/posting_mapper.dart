import 'package:cuteshrew/core/data/dto/community_dto.dart';
import 'package:cuteshrew/core/data/dto/posting_dto.dart';
import 'package:cuteshrew/core/data/dto/user_dto.dart';
import 'package:cuteshrew/core/data/mapper/community_mapper.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/data/mapper/user_mapper.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';

class PostingMapper extends Mapper<PostingDTO, PostingEntity> {
  @override
  PostingEntity map(PostingDTO object) {
    CommunityMapper communityMapper = CommunityMapper();
    UserMapper userMapper = UserMapper();

    /**
     * 기본 처리
     * title: 제목 없음 처리
     * body: 내용 없음 처리
     * isLocked: 기본적으로 잠긴 게시물이 아닌걸로 처리
     * publishedAt, updatedAt: 시간 정보 없음 처리
     * writer: nickname, email로 처리
     * ownCommunity: 커뮤니티 없음 처리
     * commentCount: 기본 개수 0개로 처리
     */
    return PostingEntity(
      postId: object.postId,
      title: object.title ?? "",
      body: object.body ?? "",
      isLocked: object.isLocked ?? false,
      publishedAt: object.publishedAt ?? 0,
      updatedAt: object.updatedAt ?? 0,
      writer: userMapper.map(
        object.writerInfo ??
            const UserDTO(nickname: "nickname", email: "email"),
      ),
      ownCommunity: communityMapper.map(
        object.ownCommunity ?? const CommunityDTO(id: 0),
      ),
      commentCount: object.commnetCount ?? 0,
    );
  }
}
