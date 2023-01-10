class UserDTO {
  final String nickname;
  final String email;
  final String? password;
  final String? introduction;
  final int? postingCount;
  final int? commentCount;

  const UserDTO({
    required this.nickname,
    required this.email,
    this.password,
    this.introduction,
    this.postingCount,
    this.commentCount,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      nickname: json['nickname'],
      email: json['email'],
      password: json['password'],
      introduction: json['introduction'],
      postingCount: json['posting_count'],
      commentCount: json['comment_count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'email': email,
        'password': password,
        'introduction': introduction,
        'posting_count': postingCount,
        'comment_count': commentCount,
      };
}
