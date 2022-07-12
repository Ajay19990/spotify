import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/auth_module/bloc/auth_bloc.dart';
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
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/albums.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.black.withOpacity(0.75),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            elevation: 0,
            title: const Padding(
              padding: EdgeInsets.only(top: 18.0, left: 8.0),
              child: Text(
                'Spotify',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/spotify.png', height: 80, width: 80),
                    const SizedBox(height: 40),
                    const Text(
                      'Listen to Millions\nof Songs on\nthe go.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: TextButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthWebViewPage(),
                      ),
                    ).then((oauthModel) {
                      if (oauthModel != null) {
                        if (oauthModel.success) {
                          if (oauthModel.code == '' ||
                              oauthModel.code == null) {
                            log('empty code from oauth model. Can\'t call bloc event');
                            return;
                          }

                          BlocProvider.of<AuthTokenBloc>(context).add(
                            GetAuthTokens(code: oauthModel.code!),
                          );
                        }
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 46,
                    child: const Center(
                      child: Text(
                        'Sign in with Spotify',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
