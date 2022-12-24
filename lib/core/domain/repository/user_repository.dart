import 'package:cuteshrew/core/domain/entity/user_create_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  // 유저 생성하기
  Future<Either<Failure, void>> createUser({UserCreateEntity newUser});
  // 유저 기본 정보 가져오기
  Future<Either<Failure, UserEntity>> getUser({String userName});
}
