import 'package:cuteshrew/presentation/data/user_data.dart';

// 유저생성시 필요한 데이터 모델
class UserCreateData extends UserData {
  final String password;

  const UserCreateData({
    required String name,
    required String email,
    required this.password,
  }) : super(name: name, email: email);
}
