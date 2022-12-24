import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_preview_entity.dart';
import 'package:cuteshrew/core/domain/repository/community_repository.dart';
import 'package:cuteshrew/core/domain/repository/posting_repository.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

class ShowCommunityPageUseCase {
  late CommunityRepository communityRepository;
  late PostingRepository postingRepository;

  ShowCommunityPageUseCase({
    required this.communityRepository,
    required this.postingRepository,
  });

  // 커뮤니티 정보를 가져온다.
  Future<Either<Failure, CommunityEntity>> call(String communityName) {
    return communityRepository.getCommunity(communityName: communityName);
  }

  // 커뮤니티의 포스팅 정보를 가져온다.
  Future<Either<Failure, List<PostingPreviewEntity>>> loadPage(
      String communityName, int pageNum, int loadCount) {
    return postingRepository.getPostingPage(
        communityPath: communityName, pageNum: pageNum, loadCount: loadCount);
  }
}
