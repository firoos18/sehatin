part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  final AuthModel? authModel;

  const LoginEvent({this.authModel});

  @override
  List<Object?> get props => [authModel];
}

final class LoginButtonTapped extends LoginEvent {
  const LoginButtonTapped({super.authModel});
}
