part of 'get_user_cubit.dart';

@immutable
sealed class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

final class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserSuccess extends GetUserState {
  final UserModel userModel;

  const GetUserSuccess(this.userModel);

  @override
  List<Object> get props => [userModel];
}

class GetUserError extends GetUserState {
  final String? message;

  const GetUserError({this.message});
}
