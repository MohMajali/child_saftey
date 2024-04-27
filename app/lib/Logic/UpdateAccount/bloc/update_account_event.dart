part of 'update_account_bloc.dart';

@immutable
sealed class UpdateAccountEvent extends Equatable {
  const UpdateAccountEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends UpdateAccountEvent {}

class UpdateAccountButtonPressed extends UpdateAccountEvent {
  final String name, email, password, phone;
  final int userId;

  const UpdateAccountButtonPressed(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.userId});
}
