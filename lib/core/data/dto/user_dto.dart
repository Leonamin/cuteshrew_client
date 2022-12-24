class UserDTO {
  final String nickname;
  final String email;
  final String? password;

  const UserDTO({required this.nickname, required this.email, this.password});

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
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
