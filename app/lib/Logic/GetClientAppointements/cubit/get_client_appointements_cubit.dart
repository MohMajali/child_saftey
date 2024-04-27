import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/appointements_model.dart';
import 'package:ecommerce/Data/Repo/clinks_repo.dart';
import 'package:meta/meta.dart';

part 'get_client_appointements_state.dart';

class GetClientAppointementsCubit extends Cubit<GetClientAppointementsState> {
  ClinksRepo clinksRepo;
  AppointementsDetailsModel model =
      AppointementsDetailsModel(error: false, clientAppointments: []);
  GetClientAppointementsCubit(this.clinksRepo)
      : super(GetClientAppointementsInitial());

  AppointementsDetailsModel appointementsDetailsModel(int clientId) {
    clinksRepo
        .getClientAppointements(clientId)
        .then((value) => {
              emit(GetClientAppointementsLoading()),
              emit(GetClientAppointementsSuccess(value)),
              model = value
            })
        .catchError((onError) async {
      log("ERROR GETTING Appointements CUBIT ==> $onError");
      emit(GetClientAppointementsError(message: "Something went wrong"));
      return onError;
    });
    return model;
  }
}
