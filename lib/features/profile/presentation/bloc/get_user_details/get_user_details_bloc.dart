import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/profile/domain/entities/user_details_entity.dart';
import 'package:sehatin/features/profile/domain/usecases/get_user_details_usecase.dart';

part 'get_user_details_event.dart';
part 'get_user_details_state.dart';

class GetUserDetailsBloc
    extends Bloc<GetUserDetailsEvent, GetUserDetailsState> {
  final GetUserDetailsUseCase _getUserDetailsUseCase;

  GetUserDetailsBloc(this._getUserDetailsUseCase)
      : super(GetUserDetailsInitial()) {
    on<GetUserDetailsEvent>(onGetUserDetails);
  }

  void onGetUserDetails(
      GetUserDetailsEvent event, Emitter<GetUserDetailsState> emit) async {
    emit(GetUserDetailsLoading());

    final data =
        await _getUserDetailsUseCase.userDetailsRepository.getUserDetails();

    data.fold(
      ifLeft: (left) => emit(GetUserDetailsFailed(message: left.message)),
      ifRight: (right) => emit(GetUserDetailsLoaded(userDetailsEntity: right)),
    );
  }
}
