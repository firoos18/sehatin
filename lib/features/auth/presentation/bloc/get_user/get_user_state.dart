part of 'get_user_bloc.dart';

sealed class GetUserState extends Equatable {
  final UserEntity? userEntity;
  final String? message;

  const GetUserState({this.message, this.userEntity});

  @override
  List<Object?> get props => [userEntity, message];
}

final class GetUserInitial extends GetUserState {}

final class GetUserLoading extends GetUserState {}

final class GetUserSuccess extends GetUserState {
  const GetUserSuccess({super.userEntity});
}

final class GetUserFailed extends GetUserState {
  const GetUserFailed({super.message});
}
