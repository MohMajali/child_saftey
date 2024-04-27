part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

class SignupLoading extends SignUpState {}

class UserSignupSuccess extends SignUpState {
  String message = "";
  UserSignupSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class UserSignupError extends SignUpState {
  final String? message;

  const UserSignupError({this.message});
}
