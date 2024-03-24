import 'package:cuteshrew/core/data/datasource/remote/user_remote_datasource.dart';
import 'package:cuteshrew/2_data/remote/user/user_summary_res.dart';
import 'package:cuteshrew/core/data/mapper/user_create_mapper.dart';
import 'package:cuteshrew/core/data/mapper/user_mapper.dart';
import 'package:cuteshrew/core/domain/entity/user_detail_entity.dart';
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
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserDetailEntity>> getUser(
      {required String userName}) async {
    try {
      UserSummaryRes userDTO =
          await _userRemoteDataSource.getUserDetail(userName);
      UserDetailMapper mapper = UserDetailMapper();
      return Right(mapper.map(userDTO));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
