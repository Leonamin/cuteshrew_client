import 'package:cuteshrew/core/domain/entity/user_create_entity.dart';
import 'package:cuteshrew/core/domain/repository/user_repository.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

// 나중에 복잡해질것 같아서 로그인에서 분리
class SigninUseCase {
  late UserRepository userRepository;

  SigninUseCase({required this.userRepository});

  Future<Either<Failure, void>> call(UserCreateEntity newUser) {
    return userRepository.createUser(newUser: newUser);
  }
}
