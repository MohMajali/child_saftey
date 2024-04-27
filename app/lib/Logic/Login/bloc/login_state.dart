part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class UserLoginSuccess extends LoginState {
  int userId = 0;
  UserLoginSuccess({required this.userId});

  @override
  List<Object> get props => [userId];
}

class UserLoginError extends LoginState {
  final String? message;

  const UserLoginError({this.message});
}
