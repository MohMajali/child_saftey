import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Repo/clinks_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'make_appointement_event.dart';
part 'make_appointement_state.dart';

class MakeAppointementBloc
    extends Bloc<MakeAppointementEvent, MakeAppointementState> {
  ClinksRepo clinksRepo;
  MakeAppointementBloc(
      MakeAppointementState makeAppointementState, this.clinksRepo)
      : super(makeAppointementState) {
    on<StartEvent>((event, emit) => emit(MakeAppointementInitial()));

    on<makeAppointementButtonPressed>((event, emit) async {
      try {
        emit(makeAppointementLoading());

        var appointmentRes = await clinksRepo.makeAppointement(
            event.serviceId!, event.clientId!, event.doctorId!, event.dateId!);

        if (!appointmentRes['error']) {
          emit(makeAppointementSuccess(message: "Appointment Added"));
        } else {
          emit(makeAppointementError(message: "Something went wrong"));
        }
      } catch (err) {
        log("Make Appointement ERROR BLOC ===> $err");
        emit(makeAppointementError(message: "Something went wrong"));
      }
    });
  }
}
