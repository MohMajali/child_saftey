part of 'get_locations_cubit.dart';

@immutable
sealed class GetLocationsState {}

final class GetLocationsInitial extends GetLocationsState {}

class GetLocationsLoading extends GetLocationsState {}

class GetLocationsSuccess extends GetLocationsState {
  final LocationModel locationModel;

  GetLocationsSuccess(this.locationModel);

  @override
  List<Object> get props => [locationModel];
}

class GetLocationsError extends GetLocationsState {
  final String? message;

  GetLocationsError({this.message});
}
