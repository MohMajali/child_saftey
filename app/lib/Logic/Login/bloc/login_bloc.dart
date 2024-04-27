import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Repo/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepo userRepo;

  LoginBloc(LoginState loginState, this.userRepo) : super(loginState) {
    on<StartEvent>((event, emit) => emit(LoginInitial()));

    on<LoginButtonPressed>((event, emit) async {
      try {
        emit(LoginLoading());

        var user = await userRepo.login(event.family_book_id!, event.password!);
        if (!user['error']) {
          emit(UserLoginSuccess(userId: user['id']));
        } else {
          emit(const UserLoginError(message: "User Not Found"));
        }
      } catch (err) {
        log("LOGIN ERROR BLOC ===> $err");
        emit(const UserLoginError(message: "User Not Found"));
      }
    });
  }
}
