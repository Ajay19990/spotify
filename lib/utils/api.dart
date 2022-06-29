import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spotify/auth_module/services/auth_service.dart';

/// Request Abstraction

class API {
  static Future<http.Request> createRequest({
    required String url,
    required ReqestMethod method,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse(url);
    final request = http.Request(method.name, uri);

    if (body != null) {
      request.body = jsonEncode(body);
    }

    if(AuthService.instance.shouldRefreshToken()) {
      await AuthService.instance.refreshToken();
    }
    return request;
  }
}

enum ReqestMethod {
  get,
  post,
  put,
  delete,
  patch,
}

extension RequestExt on ReqestMethod {
  String get httpMethod {
    switch (this) {
      case ReqestMethod.get:
        return 'GET';
      case ReqestMethod.post:
        return 'POST';
      case ReqestMethod.put:
        return 'PUT';
      case ReqestMethod.delete:
        return 'DELETE';
      case ReqestMethod.patch:
        return 'PATCH';
    }
  }
}
