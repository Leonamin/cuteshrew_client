class UserInfo {
  final String name;
  final String email;

  const UserInfo({required this.name, required this.email});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['nickname'],
      email: json['email'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserInfo && name == other.name && email == other.email);

  @override
  int get hashCode => Object.hash(name, email);
}
