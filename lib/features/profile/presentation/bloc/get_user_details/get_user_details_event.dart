part of 'get_user_details_bloc.dart';

sealed class GetUserDetailsEvent extends Equatable {
  const GetUserDetailsEvent();

  @override
  List<Object?> get props => [];
}

final class GetUserDetails extends GetUserDetailsEvent {}
