import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Repo/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  UserRepo userRepo;

  SignUpBloc(SignUpState signUpState, this.userRepo) : super(signUpState) {
    on<StartEvent>((event, emit) => emit(SignUpInitial()));

    on<SignupButtonPressed>((event, emit) async {
      try {
        emit(SignupLoading());

        final singupMessage = await userRepo.signUp(
            event.nationalId,
            event.familyBookId,
            event.name,
            event.email,
            event.password,
            event.phone);

        if (singupMessage == "Account Created Successfully") {
          emit(UserSignupSuccess(message: "Account Created Successfully"));
        } else {
          emit(const UserSignupError(message: "Account Already Exist"));
        }
      } catch (err) {
        log("Sign up Bloc Error ====> $err");
        emit(const UserSignupError(message: "Account Already Exist"));
      }
    });
  }
}
