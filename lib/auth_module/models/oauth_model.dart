class OauthModel {
  final String? code;
  final String? error;
  final bool success;

  OauthModel({
    required this.code,
    required this.error,
    required this.success,
  });
}
