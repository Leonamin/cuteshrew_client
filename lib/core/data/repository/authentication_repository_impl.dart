import 'package:cuteshrew/core/data/datasource/hive/authentication_hive_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:cuteshrew/core/data/dto/hive/login_token_hive_dto.dart';
import 'package:cuteshrew/core/data/dto/remote/login_token_dto.dart';
import 'package:cuteshrew/core/data/mapper/login_token_mapper.dart';
import 'package:cuteshrew/core/data/mapper/signed_user_mapper.dart';
import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/entity/signed_user_entity.dart';
import 'package:cuteshrew/core/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cuteshrew/core/resources/failure.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  late AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  late AuthenticationHiveDataSource _authenticationHiveDataSource;

  AuthenticationRepositoryImpl({
    required AuthenticationRemoteDataSource authenticationRemoteDataSource,
    required AuthenticationHiveDataSource authenticationHiveDataSource,
  }) {
    _authenticationRemoteDataSource = authenticationRemoteDataSource;
    _authenticationHiveDataSource = authenticationHiveDataSource;
  }

  @override
  Future<Either<Failure, void>> cleanTokens() async {
    // TODO: implement cleanTokens

    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteToken({required String nickname}) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LoginTokenEntity>> getToken(
      {required String nickname}) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<LoginTokenEntity>>> getTokenList() {
    // TODO: implement getTokenList
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LoginTokenEntity>> requestLogin(
      {required String nickname, required String password}) async {
    try {
      LoginTokenMapper mapper = LoginTokenMapper();
      LoginTokenDTO loginTokenDTO =
          await _authenticationRemoteDataSource.postLogin(nickname, password);
      LoginTokenEntity result = mapper.map(loginTokenDTO);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  // FIXME 토큰 저장시 유저 정보를 가져오게 수정해야한다.
  Future<Either<Failure, LoginTokenEntity>> saveToken({
    required String nickname,
    required LoginTokenEntity loginTokenEntity,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteSignedUser() async {
    try {
      return Right(_authenticationHiveDataSource.deleteToken());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SignedUserEntity>> getSignedUser() async {
    try {
      final LoginTokenHiveDTO loginTokenHiveDTO =
          await _authenticationHiveDataSource.getToken();
      SignedUserMapper mapper = SignedUserMapper();
      final SignedUserEntity result = mapper.map(loginTokenHiveDTO);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SignedUserEntity>> setSignedUser(
      {required SignedUserEntity signedUserEntity}) async {
    try {
      final LoginTokenHiveDTO loginTokenHiveDTO = LoginTokenHiveDTO(
        name: signedUserEntity.userInfo.name,
        email: signedUserEntity.userInfo.email,
        accessToken: signedUserEntity.loginTokenEntity.accessToken,
        tokenType: signedUserEntity.loginTokenEntity.tokenType,
        expires: signedUserEntity.loginTokenEntity.expires,
      );

      _authenticationHiveDataSource.setToken(authTokenDTO: loginTokenHiveDTO);
      return Right(signedUserEntity);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
