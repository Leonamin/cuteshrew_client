import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CommunityRepository {
  // 커뮤니티 정보 가져오기
  Future<Either<Failure, CommunityEntity>> getCommunity({
    required String communityName,
  });

  Future<Either<Failure, List<CommunityEntity>>> getCommunityList(
      {required int loadCount});
}
