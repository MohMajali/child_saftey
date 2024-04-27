part of 'make_appointement_bloc.dart';

@immutable
sealed class MakeAppointementEvent extends Equatable {
  const MakeAppointementEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends MakeAppointementEvent {}

class makeAppointementButtonPressed extends MakeAppointementEvent {
  final int? serviceId, clientId, doctorId, dateId;

  makeAppointementButtonPressed(
      {this.serviceId, this.clientId, this.doctorId, this.dateId});
}
