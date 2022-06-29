import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/auth_module/models/token_model.dart';
import 'package:spotify/auth_module/services/auth_service.dart';

class GetAuthTokens {
  final String code;
  GetAuthTokens({required this.code});
}

abstract class AuthTokenState {}

class AuthTokenInitialState extends AuthTokenState {}

class AuthTokenLoadingState extends AuthTokenState {}

class AuthTokenFailed extends AuthTokenState {
  final String err;

  AuthTokenFailed({required this.err});
}

class AuthTokenSuccessState extends AuthTokenState {
  AuthTokenResponse authTokenResponse;
  AuthTokenSuccessState({required this.authTokenResponse});
}

class AuthTokenBloc extends Bloc<GetAuthTokens, AuthTokenState> {
  AuthTokenBloc() : super((AuthTokenInitialState())) {
    on<GetAuthTokens>((event, emit) async {
      emit(AuthTokenLoadingState());

      try {
        final authTokenResponse =
            await AuthService.instance.getToken(code: event.code);
        emit(AuthTokenSuccessState(authTokenResponse: authTokenResponse));
      } catch (e) {
        log('e: ${e.toString()}');
      }
    });
  }
}
