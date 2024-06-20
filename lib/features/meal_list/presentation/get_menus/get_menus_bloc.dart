import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/meal_list/domain/entities/menu_entity.dart';
import 'package:sehatin/features/meal_list/domain/usecases/get_menus_usecase.dart';

part 'get_menus_event.dart';
part 'get_menus_state.dart';

class GetMenusBloc extends Bloc<GetMenusEvent, GetMenusState> {
  final GetMenusUsecase _getMenusUsecase;

  GetMenusBloc(this._getMenusUsecase) : super(GetMenusInitial()) {
    on<GetMenusEvent>(onGetMenus);
  }

  void onGetMenus(GetMenusEvent event, Emitter<GetMenusState> emit) async {
    emit(GetMenusLoading());

    final data = await _getMenusUsecase.menuRepository.getMenus();

    data.fold(
      ifLeft: (left) => emit(GetMenusFailed(message: left.message)),
      ifRight: (right) => emit(GetMenusLoaded(menuList: right)),
    );
  }
}
