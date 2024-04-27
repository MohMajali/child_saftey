part of 'get_client_appointements_cubit.dart';

@immutable
sealed class GetClientAppointementsState {}

final class GetClientAppointementsInitial extends GetClientAppointementsState {}

class GetClientAppointementsLoading extends GetClientAppointementsState {}

class GetClientAppointementsSuccess extends GetClientAppointementsState {
  final AppointementsDetailsModel appointementsDetailsModel;

  GetClientAppointementsSuccess(this.appointementsDetailsModel);

  @override
  List<Object> get props => [appointementsDetailsModel];
}

class GetClientAppointementsError extends GetClientAppointementsState {
  final String? message;

  GetClientAppointementsError({this.message});
}
