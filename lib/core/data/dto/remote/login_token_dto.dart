class LoginTokenDTO {
  final String accessToken;
  final String tokenType;
  final int? expires;

  const LoginTokenDTO({
    required this.accessToken,
    required this.tokenType,
    this.expires,
  });

  factory LoginTokenDTO.fromJson(Map<String, dynamic> json) {
    return LoginTokenDTO(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expires: json['expires'],
    );
  }

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'token_type': tokenType,
        'expires': expires,
      };
}
