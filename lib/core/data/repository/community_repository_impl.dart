import 'package:cuteshrew/core/data/datasource/remote/community_remote_datasource.dart';
import 'package:cuteshrew/core/data/dto/community_dto.dart';
import 'package:cuteshrew/core/data/mapper/community_mapper.dart';
import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cuteshrew/core/resources/failure.dart';

class CommunityRepositoryImpl extends CommunityRepository {
  late CommunityRemoteDataSource _communityRemoteDataSource;

  CommunityRepositoryImpl(
      {required CommunityRemoteDataSource communityRemoteDataSource}) {
    _communityRemoteDataSource = communityRemoteDataSource;
  }

  @override
  Future<Either<Failure, CommunityEntity>> getCommunity(
      {required String communityName}) async {
    try {
      CommunityDTO communityDTO =
          await _communityRemoteDataSource.getCommunityPage(communityName);
      CommunityMapper mapper = CommunityMapper();
      CommunityEntity result = mapper.map(communityDTO);

      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommunityEntity>>> getCommunityList(
      {required int loadCount}) async {
    try {
      List<CommunityDTO> communityDTO =
          await _communityRemoteDataSource.getCommunities(loadCount);
      CommunityMapper mapper = CommunityMapper();
      List<CommunityEntity> result =
          communityDTO.map((e) => mapper.map(e)).toList();

      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommunityEntity>>> getMainCommunityList() async {
    try {
      List<CommunityDTO> communityDTO =
          await _communityRemoteDataSource.getMainCommunities();
      CommunityMapper mapper = CommunityMapper();
      List<CommunityEntity> result =
          communityDTO.map((e) => mapper.map(e)).toList();

      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
