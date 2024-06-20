part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  final UserEntity? userEntity;
  final String? message;

  const RegisterState({this.message, this.userEntity});

  @override
  List<Object?> get props => [message, userEntity];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess({super.userEntity});
}

final class RegisterFailed extends RegisterState {
  const RegisterFailed({super.message});
}
