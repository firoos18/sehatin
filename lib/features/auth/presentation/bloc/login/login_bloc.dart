import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/auth/data/models/auth_model.dart';
import 'package:sehatin/features/auth/domain/entities/user_entity.dart';
import 'package:sehatin/features/auth/domain/usecases/user_login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserLoginUsecase _userLoginUsecase;

  LoginBloc(this._userLoginUsecase) : super(LoginInitial()) {
    on<LoginButtonTapped>(onLoginButtonTapped);
  }

  void onLoginButtonTapped(LoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    if (event.authModel != null) {
      final data =
          await _userLoginUsecase.authRepository.login(event.authModel!);

      data.fold(
        ifLeft: (left) => emit(LoginFailed(message: left.message)),
        ifRight: (right) => emit(LoginSuccess(userEntity: right)),
      );
    } else {
      emit(const LoginFailed(message: 'Login data is empty!'));
    }
  }
}
