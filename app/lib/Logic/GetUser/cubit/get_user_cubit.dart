import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/user_model.dart';
import 'package:ecommerce/Data/Repo/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  UserRepo userRepo;
  UserModel userModel = UserModel(
      userData: UserData(id: 0, name: '', phone: '', password: '', email: ''));
  GetUserCubit(this.userRepo) : super(GetUserInitial());

  UserModel getUserModel(int id) {
    userRepo
        .getUserData(id)
        .then((value) => {
              emit(GetUserLoading()),
              emit(GetUserSuccess(value)),
              userModel = value
            })
        .catchError((onError) async {
      log("ERROR GETTING USER CUBIT ==> $onError");
      emit(const GetUserError(message: "Something went wrong"));
    });
    return userModel;
  }
}
