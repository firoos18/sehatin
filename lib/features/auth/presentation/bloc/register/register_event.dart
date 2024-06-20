part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  final AuthModel? authModel;

  const RegisterEvent({this.authModel});

  @override
  List<Object?> get props => [authModel];
}

final class RegisterButtonTapped extends RegisterEvent {
  const RegisterButtonTapped({super.authModel});
}
