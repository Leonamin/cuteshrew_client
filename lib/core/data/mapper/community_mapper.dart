import 'package:cuteshrew/core/data/dto/community_dto.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/domain/entity/community_entity.dart';

class CommunityMapper extends Mapper<CommunityDTO, CommunityEntity> {
  @override
  CommunityEntity map(CommunityDTO object) {
    return CommunityEntity(
        communityName: object.communityName ?? "None",
        communityShowName: object.communityShowName ?? "None",
        postingCount: object.postingsCount ?? 0);
  }
}
