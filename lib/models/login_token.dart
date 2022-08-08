class LoginToken {
  final String accessToken;
  final String tokenType;

  const LoginToken({required this.accessToken, required this.tokenType});

  factory LoginToken.fromJson(Map<String, dynamic> json) {
    return LoginToken(
        accessToken: json['access_token'], tokenType: json['token_type']);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginToken &&
          accessToken == other.accessToken &&
          tokenType == other.tokenType);

  @override
  int get hashCode => Object.hash(accessToken, tokenType);
}
