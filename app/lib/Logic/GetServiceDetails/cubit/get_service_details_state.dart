part of 'get_service_details_cubit.dart';

@immutable
sealed class GetServiceDetailsState {}

final class GetServiceDetailsInitial extends GetServiceDetailsState {}

class GetServiceDetailsLoading extends GetServiceDetailsState {}

class GetServiceDetailsSuccess extends GetServiceDetailsState {
  final ServiceDetailsModel serviceModel;

  GetServiceDetailsSuccess(this.serviceModel);

  @override
  List<Object> get props => [serviceModel];
}

class GetServiceDetailsError extends GetServiceDetailsState {
  final String? message;

  GetServiceDetailsError({this.message});
}
