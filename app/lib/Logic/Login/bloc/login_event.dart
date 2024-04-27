part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String? family_book_id;
  final String? password;

  const LoginButtonPressed({this.family_book_id, this.password});
}
