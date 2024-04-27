import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/service_model.dart';
import 'package:ecommerce/Data/Repo/clinks_repo.dart';
import 'package:meta/meta.dart';

part 'get_services_state.dart';

class GetServicesCubit extends Cubit<GetServicesState> {
  ClinksRepo clinksRepo;
  ServiceModel serviceModel = ServiceModel(error: false, services: []);
  GetServicesCubit(this.clinksRepo) : super(GetServicesInitial());

  ServiceModel getServicesOnClinkId(int clindId) {
    clinksRepo
        .getServicesOnClinkId(clindId)
        .then((value) => {
              emit(GetServicesLoading()),
              emit(GetServicesSuccess(serviceModel)),
              serviceModel = value
            })
        .catchError((onError) async {
      log("ERROR GETTING Services CUBIT ==> $onError");
      emit(GetServicesError(message: "Something went wrong"));
      return onError;
    });
    return serviceModel;
  }
}
