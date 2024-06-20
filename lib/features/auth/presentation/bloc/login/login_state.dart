part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  final UserEntity? userEntity;
  final String? message;

  const LoginState({this.userEntity, this.message});

  @override
  List<Object?> get props => [userEntity, message];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  const LoginSuccess({super.userEntity});
}

final class LoginFailed extends LoginState {
  const LoginFailed({super.message});
}
