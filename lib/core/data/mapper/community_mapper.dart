import 'package:cuteshrew/core/data/dto/community_dto.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/data/mapper/posting_preview_mapper.dart';
import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/community_preview_entity.dart';

class CommunityMapper extends Mapper<CommunityDTO, CommunityEntity> {
  @override
  CommunityEntity map(CommunityDTO object) {
    PostingPreviewMapper postingMapper = PostingPreviewMapper();
    /*
      기본처리
      communityName: 없음 처리
      communityShowname: 없음 처리
      postingCount: 0개로 처리
     */
    return CommunityPreviewEntity(
      communityName: object.communityName ?? "",
      communityShowName: object.communityShowName ?? "",
      postingCount: object.postingsCount ?? 0,
      postings: [for (final e in object.postings ?? []) postingMapper.map(e)],
    );
  }
}
