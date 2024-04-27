part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends SignUpEvent {}

class SignupButtonPressed extends SignUpEvent {
  final String nationalId, familyBookId, name, email, password, phone;

  const SignupButtonPressed(
      {required this.nationalId,
      required this.familyBookId,
      required this.name,
      required this.email,
      required this.password,
      required this.phone});
}
