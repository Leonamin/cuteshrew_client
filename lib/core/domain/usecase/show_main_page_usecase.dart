import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_preview_entity.dart';
import 'package:cuteshrew/core/domain/repository/community_repository.dart';
import 'package:cuteshrew/core/domain/repository/posting_repository.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

class ShowMainPageUseCase {
  late CommunityRepository communityRepository;
  late PostingRepository postingRepository;

  // 이것을 비즈니스 로직인 유즈케이스에서 정하는것은 별로 안좋아 보인다.
  // final int defaultLoadCommunityCount = 5;
  // final int defaultLoadPostingCount = 5;

  ShowMainPageUseCase({
    required this.communityRepository,
    required this.postingRepository,
  });

  // 메인 페이지의 커뮤니티들을 가져온다
  Future<Either<Failure, List<CommunityEntity>>> call(int loadCount) {
    return communityRepository.getMainCommunityList();
  }

  // 커뮤니티의 미리보기 포스팅들을 가져온다.
  Future<Either<Failure, List<PostingPreviewEntity>>> loadPage(
      String communityName, int loadCount) {
    return postingRepository.getPostingPage(
      communityPath: communityName,
      pageNum: 1,
      loadCount: loadCount,
    );
  }
}
