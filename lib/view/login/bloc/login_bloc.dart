import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foody_bloc_app/data/user_login_data.dart';
import 'package:foody_bloc_app/view/login/bloc/login_event.dart';
import 'package:foody_bloc_app/view/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool isUSerFound = false;

  LoginBloc() : super(OnLoginInitialState()) {
    on<LoginButtonClickEvent>(_onLoginButtonClick);
  }

  FutureOr<void> _onLoginButtonClick(
      LoginButtonClickEvent event, Emitter<LoginState> emit) async {
    emit(OnLoginLoadingState());

    await Future.delayed(const Duration(seconds: 3));

    String email = event.email.trim();
    String password = event.password.trim();

    for (final user in userLoginData) {
      if (user.email == email && user.password == password) {
        isUSerFound = true;
        break;
      }
    }

    if (!isUSerFound) {
      emit(OnLoginFailureState());
    } else {
      emit(OnLoginSuccessState());
    }
  }
}
