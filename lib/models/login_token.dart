class TestLoginToken {
  final String accessToken;
  final String tokenType;

  const TestLoginToken({required this.accessToken, required this.tokenType});

  factory TestLoginToken.fromJson(Map<String, dynamic> json) {
    return TestLoginToken(
        accessToken: json['access_token'], tokenType: json['token_type']);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestLoginToken &&
          accessToken == other.accessToken &&
          tokenType == other.tokenType);

  @override
  int get hashCode => Object.hash(accessToken, tokenType);
}
