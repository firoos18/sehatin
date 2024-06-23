import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/auth/domain/usecases/user_log_out_usecase.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final UserLogOutUseCase _userLogOutUseCase;

  LogoutBloc(this._userLogOutUseCase) : super(LogoutInitial()) {
    on<LogOutButtonTapped>(onLogOutButtonTapped);
  }

  void onLogOutButtonTapped(
      LogoutEvent event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading());

    final data = await _userLogOutUseCase.authRepository.logout();

    data.fold(
      ifLeft: (left) => emit(LogoutFailed(message: left.message)),
      ifRight: (right) => emit(LogoutSuccess()),
    );
  }
}
