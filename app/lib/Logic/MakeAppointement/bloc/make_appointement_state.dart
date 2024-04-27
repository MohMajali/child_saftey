part of 'make_appointement_bloc.dart';

@immutable
sealed class MakeAppointementState {}

final class MakeAppointementInitial extends MakeAppointementState {}

class makeAppointementLoading extends MakeAppointementState {}

class makeAppointementSuccess extends MakeAppointementState {
  String message = '';
  makeAppointementSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class makeAppointementError extends MakeAppointementState {
  final String? message;

  makeAppointementError({this.message});
}
