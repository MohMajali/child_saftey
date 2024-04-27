part of 'update_account_bloc.dart';

@immutable
sealed class UpdateAccountState extends Equatable {
  const UpdateAccountState();

  @override
  List<Object> get props => [];
}

final class UpdateAccountInitial extends UpdateAccountState {}

class UpdateAccountLoading extends UpdateAccountState {}

class UpdateAccountSuccess extends UpdateAccountState {
  String message = "";
  UpdateAccountSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateAccountError extends UpdateAccountState {
  final String? message;

  const UpdateAccountError({this.message});
}
