import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/auth_module/auth_constants.dart';
import 'package:spotify/auth_module/bloc/auth_bloc.dart';
import 'package:spotify/auth_module/screens/auth_signin_page.dart';
import 'package:spotify/home_module/screens/home_page.dart';
import 'package:spotify/utils/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateNext();
  }

  Future navigateNext() async {
    final accessToken = SharedPrefs.getString(AuthConstants.accessTokenKey);
    if (accessToken.isNotEmpty) {
      // We are logged in
      final route = MaterialPageRoute(
        builder: (context) => HomePage(),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, route);
      });
    } else {
      final route = MaterialPageRoute(
        builder: (context) => BlocProvider<AuthTokenBloc>(
          create: (BuildContext context) => AuthTokenBloc(),
          child: const AuthSignInPage(),
        ),
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, route);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Image.asset(
        'images/spotify.png',
        height: 100,
        width: 100,
      )),
    );
  }
}
