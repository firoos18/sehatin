part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  final String? message;

  const LogoutState({this.message});

  @override
  List<Object?> get props => [message];
}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutSuccess extends LogoutState {}

final class LogoutFailed extends LogoutState {
  const LogoutFailed({super.message});
}
