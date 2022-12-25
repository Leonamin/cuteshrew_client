import 'package:cuteshrew/presentation/data/user_data.dart';

// 기본 유저 정보를 상속 받고 최소 정보만 담긴 데이터
class UserPreviewData extends UserData {
  const UserPreviewData({
    required String name,
    required String email,
  }) : super(name: name, email: email);
}
