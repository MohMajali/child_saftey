import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/location_model.dart';
import 'package:ecommerce/Data/Repo/clinks_repo.dart';
import 'package:meta/meta.dart';

part 'get_locations_state.dart';

class GetLocationsCubit extends Cubit<GetLocationsState> {
  ClinksRepo clinksRepo;
  LocationModel locationModel = LocationModel(error: false, locations: []);
  GetLocationsCubit(this.clinksRepo) : super(GetLocationsInitial());

  LocationModel getLocations() {
    clinksRepo
        .getLocations()
        .then((value) => {
              emit(GetLocationsLoading()),
              emit(GetLocationsSuccess(value)),
              locationModel = value
            })
        .catchError((onError) async {
      log("ERROR GETTING Locations CUBIT ==> $onError");
      emit(GetLocationsError(message: "Something went wrong"));
      return onError;
    });
    return locationModel;
  }
}
