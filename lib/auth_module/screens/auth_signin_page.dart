import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/auth_module/bloc/auth_bloc.dart';
import 'package:spotify/auth_module/models/oauth_model.dart';
import 'package:spotify/auth_module/screens/auth_webview_page.dart';

class AuthSignInPage extends StatefulWidget {
  const AuthSignInPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthSignInPage> createState() => _AuthSignInPageState();
}

class _AuthSignInPageState extends State<AuthSignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify'),
      ),
      body: Center(
          child: TextButton(
        onPressed: () async {
          OauthModel? oauthModel = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthWebViewPage(),
            ),
          );

          if (oauthModel != null) {
            if (oauthModel.success) {
              if (oauthModel.code == '' || oauthModel.code == null) {
                log('empty code from oauth model. Can\'t call bloc event');
                return;
              }

              BlocProvider.of<AuthTokenBloc>(context).add(
                GetAuthTokens(code: oauthModel.code!),
              );
            }
          }
        },
        child: const Text('Sign in'),
      )),
    );
  }
}
