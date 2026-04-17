import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {

    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      await Future.delayed(const Duration(seconds: 1));

      if (event.username == "admin" && event.password == "123") {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Login gagal"));
      }
    });

  }
}