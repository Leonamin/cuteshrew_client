class LoginTokenDTO {
  final String accessToken;
  final String tokenType;

  const LoginTokenDTO({
    required this.accessToken,
    required this.tokenType,
  });

  factory LoginTokenDTO.fromJson(Map<String, dynamic> json) {
    return LoginTokenDTO(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'token_type': tokenType,
      };
}
