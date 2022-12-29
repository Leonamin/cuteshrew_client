import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_create_entity.dart';
import 'package:cuteshrew/core/domain/repository/community_repository.dart';
import 'package:cuteshrew/core/domain/repository/posting_repository.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

class CreatePostingUseCase {
  late CommunityRepository communityRepository;
  late PostingRepository postingRepository;

  CreatePostingUseCase(
      {required this.communityRepository, required this.postingRepository});

  // 모든 커뮤니티 정보를 가져온다.
  Future<Either<Failure, List<CommunityEntity>>> call() {
    return communityRepository.getCommunityList(loadCount: 0);
  }

  // 게시글 생성
  Future<Either<Failure, void>> createPosting(
    String communityName,
    PostingCreateEntity newPosting,
    LoginTokenEntity loginToken,
  ) {
    return postingRepository.createPosting(
      communityPath: communityName,
      newPosting: newPosting,
      loginToken: loginToken,
    );
  }

  // 게시글 수정
  Future<Either<Failure, void>> updatePosting(
    String communityName,
    int postId,
    PostingCreateEntity newPosting,
    LoginTokenEntity loginToken,
  ) {
    return postingRepository.updatePosting(
      communityPath: communityName,
      postId: postId,
      newPosting: newPosting,
      loginToken: loginToken,
    );
  }
}
