import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:spotify/auth_module/auth_constants.dart';
import 'package:spotify/auth_module/models/token_model.dart';
import 'package:spotify/utils/helpers.dart';
import 'package:spotify/utils/shared_prefs.dart';

class AuthService {
  AuthService._privateConstructor();
  static final instance = AuthService._privateConstructor();

  Future<AuthTokenResponse> getToken({required String code}) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    const stringToEncode =
        '${AuthConstants.clientID}:${AuthConstants.clientSecret}';

    final encodedAuthHeader = stringToBase64.encode(stringToEncode);

    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Basic $encodedAuthHeader',
    };

    final body = {
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': AuthConstants.redirectUrl,
    };

    try {
      final resp = await http.post(
        Uri.parse(AuthConstants.tokenApiUrl),
        body: body,
        headers: headers,
      );

      final Map<String, dynamic> decodedBody = jsonDecode(resp.body);
      log('getAuthTokenResponse: ${resp.body}');
      if (resp.statusCode == 200) {
        /// Success
        final authTokenResponse = AuthTokenResponse.fromJson(decodedBody);

        // Saving all the Auth info in Shared prefs
        SharedPrefs.setString(
            AuthConstants.accessTokenKey, authTokenResponse.accessToken);
        SharedPrefs.setString(
            AuthConstants.refreshTokenKey, authTokenResponse.refreshToken);
        _saveExpirationDate(authTokenResponse.expiresIn);

        return authTokenResponse;
      } else if (decodedBody.containsKey('message')) {
        throw CustomException(decodedBody['message']);
      } else {
        throw CustomException('Something went wrong');
      }
    } on SocketException {
      throw CustomException('No Internet connection');
    } on HttpException {
      throw CustomException('Something went wrong');
    } on FormatException {
      throw CustomException('Bad request');
    } catch (e) {
      log(e.toString());
      throw CustomException(e.toString());
    }
  }

  Future refreshToken() async {}

  /// Helper methods
  _saveExpirationDate(int expiresIn) {
    final now = DateTime.now();
    final expirationDate = now.add(Duration(seconds: expiresIn));
    SharedPrefs.setString(
      AuthConstants.expiresInKey,
      expirationDate.toIso8601String(),
    );
  }

  bool shouldRefreshToken() {
    final expirationDateIsoString =
        SharedPrefs.getString(AuthConstants.expiresInKey);
    if (expirationDateIsoString.isEmpty) {
      throw 'Unable to get expiration token from shared prefs';
    }
    final expirationDate = DateTime.parse(expirationDateIsoString);

    final now = DateTime.now();
    final difference = expirationDate.difference(now);
    return difference.inMinutes < 10;
  }
}
