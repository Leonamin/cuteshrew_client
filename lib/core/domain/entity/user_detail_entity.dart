import 'package:cuteshrew/core/domain/entity/user_entity.dart';

// 기본 유저 정보를 상속 받고 자세한 유저 정보를 필요로 하는 엔티티
class UserDetailEntity extends UserEntity {
  final int postingCount;
  final int commentCount;
  final String introduction;
  const UserDetailEntity({
    required this.postingCount,
    required this.commentCount,
    required this.introduction,
    required String name,
    required String email,
  }) : super(name: name, email: email);

  @override
  List<Object?> get props =>
      super.props +
      [
        postingCount,
        commentCount,
        introduction,
      ];
}
