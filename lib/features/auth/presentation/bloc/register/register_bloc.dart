import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/auth/data/models/auth_model.dart';
import 'package:sehatin/features/auth/domain/entities/user_entity.dart';
import 'package:sehatin/features/auth/domain/usecases/user_register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRegisterUseCase _userRegisterUseCase;

  RegisterBloc(this._userRegisterUseCase) : super(RegisterInitial()) {
    on<RegisterButtonTapped>(onRegisterButtonTapped);
  }

  void onRegisterButtonTapped(
      RegisterEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    if (event.authModel != null) {
      final data =
          await _userRegisterUseCase.authRepository.register(event.authModel!);

      data.fold(
        ifLeft: (left) => emit(RegisterFailed(message: left.message)),
        ifRight: (right) => emit(RegisterSuccess(userEntity: right)),
      );
    } else {
      emit(const RegisterFailed(message: 'Register data is empty!'));
    }
  }
}
