import 'package:cuteshrew/core/domain/entity/user_create_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_detail_entity.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  // 유저 생성하기
  Future<Either<Failure, void>> createUser({required UserCreateEntity newUser});
  // 유저 기본 정보 가져오기
  Future<Either<Failure, UserDetailEntity>> getUser({required String userName});
}
