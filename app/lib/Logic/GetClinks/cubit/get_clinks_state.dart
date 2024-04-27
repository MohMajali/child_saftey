part of 'get_clinks_cubit.dart';

@immutable
sealed class GetClinksState {}

final class GetClinksInitial extends GetClinksState {}

class GetClinksLoading extends GetClinksState {}

class GetClinksSuccess extends GetClinksState {
  final ClinkModel clinkModel;

  GetClinksSuccess(this.clinkModel);

  @override
  List<Object> get props => [clinkModel];
}

class GetClinksError extends GetClinksState {
  final String? message;

  GetClinksError({this.message});
}
