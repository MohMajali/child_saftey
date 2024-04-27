import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/service_details.dart';
import 'package:ecommerce/Data/Repo/clinks_repo.dart';
import 'package:meta/meta.dart';

part 'get_service_details_state.dart';

class GetServiceDetailsCubit extends Cubit<GetServiceDetailsState> {
  ClinksRepo clinksRepo;
  ServiceDetailsModel serviceDetailsModel = ServiceDetailsModel(
      error: false,
      service: ServiceData(
          id: 0, doctorId: 0, name: '', description: '', image: '', dates: []));
  GetServiceDetailsCubit(this.clinksRepo) : super(GetServiceDetailsInitial());

  ServiceDetailsModel getServiceDetails(int serviceId) {
    clinksRepo
        .getServicesOnId(serviceId)
        .then((value) => {
              emit(GetServiceDetailsLoading()),
              emit(GetServiceDetailsSuccess(value)),
              serviceDetailsModel = value
            })
        .catchError((onError) async {
      log("ERROR GETTING Service Details CUBIT ==> $onError");
      emit(GetServiceDetailsError(message: "Something went wrong"));
      return onError;
    });

    return serviceDetailsModel;
  }
}
