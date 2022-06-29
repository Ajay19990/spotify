import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spotify/auth_module/auth_constants.dart';
import 'package:spotify/auth_module/models/oauth_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthWebViewPage extends StatefulWidget {
  const AuthWebViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthWebViewPage> createState() => _AuthWebViewPageState();
}

class _AuthWebViewPageState extends State<AuthWebViewPage> {
  @override
  void initState() {
    super.initState();
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: AuthConstants.signinInitialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onPageStarted: (String url) {
          final uri = Uri.parse(url);
          if (url.contains(AuthConstants.redirectUrl)) {
            //
            if (uri.queryParameters.containsKey('code')) {
              final code = uri.queryParameters['code'];

              final oauthModel = OauthModel(
                code: code,
                error: null,
                success: true,
              );
              Navigator.pop(context, oauthModel);
            } else if (uri.queryParameters.containsKey('error')) {
              final error = uri.queryParameters['error'];

              final oauthModel = OauthModel(
                code: null,
                error: error,
                success: false,
              );
              Navigator.pop(context, oauthModel);
            }
          }
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
    );
  }
}
