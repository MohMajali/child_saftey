import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/clink_model.dart';
import 'package:ecommerce/Data/Repo/clinks_repo.dart';
import 'package:meta/meta.dart';

part 'get_clinks_state.dart';

class GetClinksCubit extends Cubit<GetClinksState> {
  ClinksRepo clinksRepo;
  ClinkModel clinkModel = ClinkModel(error: false, clinks: []);

  GetClinksCubit(this.clinksRepo) : super(GetClinksInitial());

  ClinkModel getClinks(int locationId) {
    clinksRepo
        .getClinks(locationId)
        .then((value) => {
              emit(GetClinksLoading()),
              emit(GetClinksSuccess(value)),
              clinkModel = value
            })
        .catchError((onError) async {
      log("ERROR GETTING Clinks CUBIT ==> $onError");
      emit(GetClinksError(message: "Something went wrong"));
      return onError;
    });
    return clinkModel;
  }
}
