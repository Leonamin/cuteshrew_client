class UserCreateDTO {
  final String nickname;
  final String email;
  final String password;

  const UserCreateDTO({
    required this.nickname,
    required this.email,
    required this.password,
  });

  factory UserCreateDTO.fromJson(Map<String, dynamic> json) {
    return UserCreateDTO(
      nickname: json['nickname'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'email': email,
        'password': password,
      };
}
