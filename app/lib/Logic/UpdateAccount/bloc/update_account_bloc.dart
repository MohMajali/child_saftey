import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Repo/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'update_account_event.dart';
part 'update_account_state.dart';

class UpdateAccountBloc extends Bloc<UpdateAccountEvent, UpdateAccountState> {
  UserRepo userRepo;

  UpdateAccountBloc(UpdateAccountState updateAccountState, this.userRepo)
      : super(updateAccountState) {
    on<StartEvent>((event, emit) => emit(UpdateAccountInitial()));

    on<UpdateAccountButtonPressed>((event, emit) async {
      try {
        emit(UpdateAccountLoading());

        final updateMessage = await userRepo.updateAccount(
            event.name, event.email, event.password, event.phone, event.userId);

        if (updateMessage == 'Account Updated') {
          emit(UpdateAccountSuccess(message: 'Account Updated'));
          
        } else {
          emit(const UpdateAccountError(message: 'Something Went Wrong'));
        }
      } catch (err) {
        log("Update Account Bloc Error ====> $err");
        emit(const UpdateAccountError(message: 'Something Went Wrong'));
      }
    });
  }
}
