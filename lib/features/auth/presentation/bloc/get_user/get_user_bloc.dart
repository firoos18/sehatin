import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/auth/domain/entities/user_entity.dart';
import 'package:sehatin/features/auth/domain/usecases/get_user_usecase.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final GetUserUseCase _getUserUseCase;

  GetUserBloc(this._getUserUseCase) : super(GetUserInitial()) {
    on<AppOpened>(onAppOpened);
  }

  void onAppOpened(GetUserEvent event, Emitter<GetUserState> emit) {
    emit(GetUserLoading());

    final data = _getUserUseCase.authRepository.getUser();

    data.fold(
      ifLeft: (left) => emit(GetUserFailed(message: left.message)),
      ifRight: (right) => emit(GetUserSuccess(userEntity: right)),
    );
  }
}
