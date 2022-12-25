import 'package:cuteshrew/core/data/datasource/remote/user_remote_datasource.dart';
import 'package:cuteshrew/core/data/mapper/user_create_mapper.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_create_entity.dart';
import 'package:cuteshrew/core/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cuteshrew/core/resources/failure.dart';

class UserRepositoryImpl extends UserRepository {
  late UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl({required UserRemoteDataSource userRemoteDataSource}) {
    _userRemoteDataSource = userRemoteDataSource;
  }

  @override
  Future<Either<Failure, void>> createUser(
      {required UserCreateEntity newUser}) async {
    try {
      UserCreateMapper mapper = UserCreateMapper();
      return Right(_userRemoteDataSource.postSignin(mapper.map(newUser)));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser({required String userName}) {
    throw UnimplementedError();
    // try {
    //   UserCreateMapper mapper = UserCreateMapper();
    //   return Right(_userRemoteDataSource.getUserInfo(userName));
    // } on Exception catch (e) {
    //   return Left(Failure(e.toString()));
    // }
  }
}
