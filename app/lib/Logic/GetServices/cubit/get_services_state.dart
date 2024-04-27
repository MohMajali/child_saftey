part of 'get_services_cubit.dart';

@immutable
sealed class GetServicesState {}

final class GetServicesInitial extends GetServicesState {}

class GetServicesLoading extends GetServicesState {}

class GetServicesSuccess extends GetServicesState {
  final ServiceModel serviceModel;

  GetServicesSuccess(this.serviceModel);

  @override
  List<Object> get props => [serviceModel];
}

class GetServicesError extends GetServicesState {
  final String? message;

  GetServicesError({this.message});
}
