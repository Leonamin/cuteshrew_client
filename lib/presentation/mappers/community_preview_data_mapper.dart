import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/community_preview_entity.dart';
import 'package:cuteshrew/presentation/data/community_preview_data.dart';
import 'package:cuteshrew/presentation/data/posting_data.dart';
import 'package:cuteshrew/presentation/mappers/data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/posting_preview_data_mapper.dart';

class CommunityPreviewDataMapper
    extends DataMapper<CommunityEntity, CommunityPreviewData> {
  //FIXME PostingPreviewDataMapper와 순환 참조하는 막장 구조
  @override
  CommunityPreviewData map(CommunityEntity object) {
    PostingPreviewDataMapper mapper = PostingPreviewDataMapper();

    return CommunityPreviewData(
      communityName: object.communityName,
      communityShowName: object.communityShowName,
      postingCount: object.postingCount,
      postings: (object is CommunityPreviewEntity)
          ? List<PostingData>.from(object.postings.map((e) => mapper.map(e)))
          : null,
    );
  }
}
