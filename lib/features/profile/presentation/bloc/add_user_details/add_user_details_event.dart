part of 'add_user_details_bloc.dart';

sealed class AddUserDetailsEvent extends Equatable {
  final AddUserDetailsModel? userDetailsModel;

  const AddUserDetailsEvent({this.userDetailsModel});

  @override
  List<Object?> get props => [userDetailsModel];
}

final class AddUserDetailsButtonTapped extends AddUserDetailsEvent {
  const AddUserDetailsButtonTapped({super.userDetailsModel});
}
