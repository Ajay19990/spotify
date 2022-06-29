class AuthTokenResponse {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String tokenType;

  AuthTokenResponse({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
    required this.tokenType,
  });

  factory AuthTokenResponse.fromJson(Map<String, dynamic> json) {
    return AuthTokenResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires_in'],
      tokenType: json['token_type'],
    );
  }
}

class RefreshedTokenResponse {
  final String accessToken;
  final int expiresIn;
  final String tokenType;

  RefreshedTokenResponse({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
  });

  factory RefreshedTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshedTokenResponse(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'],
      tokenType: json['token_type'],
    );
  }
}