import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/meal_list/domain/entities/menu_entity.dart';
import 'package:sehatin/features/meal_list/domain/usecases/get_menu_by_id_usecase.dart';

part 'menu_by_id_event.dart';
part 'menu_by_id_state.dart';

class MenuByIdBloc extends Bloc<MenuByIdEvent, MenuByIdState> {
  final GetMenuByIdUseCase _getMenuByIdUseCase;

  MenuByIdBloc(this._getMenuByIdUseCase) : super(MenuByIdInitial()) {
    on<GetMenuById>(onGetMenuById);
  }

  void onGetMenuById(MenuByIdEvent event, Emitter<MenuByIdState> emit) async {
    emit(MenuByIdLoading());

    final data = await _getMenuByIdUseCase.menuRepository.getMenuById(event.id);

    data.fold(
      ifLeft: (left) => emit(MenuByIdFailed(message: left.message)),
      ifRight: (right) => emit(MenuByIdLoaded(menuEntity: right)),
    );
  }
}
