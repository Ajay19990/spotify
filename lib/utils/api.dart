import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/auth_module/auth_constants.dart';
import 'package:spotify/auth_module/services/auth_service.dart';
import 'package:spotify/utils/shared_prefs.dart';

/// Request Abstraction

class API {
  static Future<http.Request> createRequest({
    required String url,
    required RequestMethod method,
    Map<String, dynamic>? body,
  }) async {

    if (AuthService.instance.shouldRefreshToken()) {
      await AuthService.instance.refreshToken();
    }

    final accessToken = SharedPrefs.getString(AuthConstants.accessTokenKey);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final uri = Uri.parse(url);
    final request = http.Request(method.name, uri);

    if (body != null) {
      request.body = jsonEncode(body);
    }

    request.headers.addAll(headers);
    return request;
  }
}

enum RequestMethod {
  get,
  post,
  put,
  delete,
  patch,
}

extension RequestExt on RequestMethod {
  String get httpMethod {
    switch (this) {
      case RequestMethod.get:
        return 'GET';
      case RequestMethod.post:
        return 'POST';
      case RequestMethod.put:
        return 'PUT';
      case RequestMethod.delete:
        return 'DELETE';
      case RequestMethod.patch:
        return 'PATCH';
    }
  }
}
