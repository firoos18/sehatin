import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/profile/data/models/add_user_details_model.dart';
import 'package:sehatin/features/profile/domain/usecases/add_user_details_usecase.dart';

part 'add_user_details_event.dart';
part 'add_user_details_state.dart';

class AddUserDetailsBloc
    extends Bloc<AddUserDetailsEvent, AddUserDetailsState> {
  final AddUserDetailsUseCase _addUserDetailsUseCase;

  AddUserDetailsBloc(this._addUserDetailsUseCase)
      : super(AddUserDetailsInitial()) {
    on<AddUserDetailsEvent>(onAddUserDetailsButtonTapped);
  }

  void onAddUserDetailsButtonTapped(
      AddUserDetailsEvent event, Emitter<AddUserDetailsState> emit) async {
    emit(AddUserDetailsLoading());

    if (event.userDetailsModel != null) {
      final data = await _addUserDetailsUseCase.userDetailsRepository
          .addUserDetails(event.userDetailsModel!);

      data.fold(
        ifLeft: (left) => emit(AddUserDetailsFailed(message: left.message)),
        ifRight: (right) => emit(AddUserDetailsSuccess()),
      );
    } else {
      emit(const AddUserDetailsFailed(message: 'User details is empty!'));
    }
  }
}
