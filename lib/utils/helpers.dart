import 'dart:convert';
import 'package:spotify/auth_module/auth_constants.dart';
import 'package:spotify/utils/shared_prefs.dart';

class Helpers {
  static String encodedAuthHeader() {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    const stringToEncode =
        '${AuthConstants.clientID}:${AuthConstants.clientSecret}';

    final encodedAuthHeader = stringToBase64.encode(stringToEncode);
    return encodedAuthHeader;
  }


  static saveExpirationDate(int expiresIn) {
    final now = DateTime.now();
    final expirationDate = now.add(Duration(seconds: expiresIn));
    SharedPrefs.setString(
      AuthConstants.expiresInKey,
      expirationDate.toIso8601String(),
    );
  }
}

class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() {
    return message;
  }
}

