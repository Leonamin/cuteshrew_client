import 'package:cuteshrew/core/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:cuteshrew/core/data/dto/login_token_dto.dart';
import 'package:cuteshrew/core/data/mapper/login_token_mapper.dart';
import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cuteshrew/core/resources/failure.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  late AuthenticationRemoteDataSource _authenticationRemoteDataSource;

  AuthenticationRepositoryImpl(
      {required AuthenticationRemoteDataSource
          authenticationRemoteDataSource}) {
    _authenticationRemoteDataSource = authenticationRemoteDataSource;
  }

  @override
  Future<Either<Failure, void>> cleanTokens() {
    // TODO: implement cleanTokens
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteToken({required String nickname}) {
    // TODO: implement deleteToken
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LoginTokenEntity>> getToken(
      {required String nickname}) {
    // TODO: implement getToken
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
  Future<Either<Failure, LoginTokenEntity>> saveToken(
      {required String nickname, required LoginTokenEntity loginTokenEntity}) {
    // TODO: implement saveToken
    throw UnimplementedError();
  }
}
