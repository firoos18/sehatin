part of 'add_user_details_bloc.dart';

sealed class AddUserDetailsState extends Equatable {
  final String? message;

  const AddUserDetailsState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

final class AddUserDetailsInitial extends AddUserDetailsState {}

final class AddUserDetailsLoading extends AddUserDetailsState {}

final class AddUserDetailsSuccess extends AddUserDetailsState {}

final class AddUserDetailsFailed extends AddUserDetailsState {
  const AddUserDetailsFailed({super.message});
}
