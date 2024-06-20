part of 'get_user_details_bloc.dart';

sealed class GetUserDetailsState extends Equatable {
  final UserDetailsEntity? userDetailsEntity;
  final String? message;

  const GetUserDetailsState({this.message, this.userDetailsEntity});

  @override
  List<Object?> get props => [userDetailsEntity, message];
}

final class GetUserDetailsInitial extends GetUserDetailsState {}

final class GetUserDetailsLoading extends GetUserDetailsState {}

final class GetUserDetailsLoaded extends GetUserDetailsState {
  const GetUserDetailsLoaded({super.userDetailsEntity});
}

final class GetUserDetailsFailed extends GetUserDetailsState {
  const GetUserDetailsFailed({super.message});
}
