import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/favorite/domain/usecases/add_favorite_item_usecase.dart';
import 'package:sehatin/features/meal_list/data/models/menu_model.dart';

part 'add_favorite_item_event.dart';
part 'add_favorite_item_state.dart';

class AddFavoriteItemBloc
    extends Bloc<AddFavoriteItemEvent, AddFavoriteItemState> {
  final AddFavoriteItemUseCase _addFavoriteItemUseCase;

  AddFavoriteItemBloc(this._addFavoriteItemUseCase)
      : super(AddFavoriteItemInitial()) {
    on<AddItemToFavoriteButtonTapped>(onAddItemToFavoriteButtonTapped);
  }

  void onAddItemToFavoriteButtonTapped(
      AddFavoriteItemEvent event, Emitter<AddFavoriteItemState> emit) async {
    emit(AddFavoriteItemLoading());

    if (event.menuModel != null) {
      final data = await _addFavoriteItemUseCase.favoriteRepository
          .addFavoriteItem(event.menuModel!);

      data.fold(
        ifLeft: (left) => emit(AddFavoriteItemFailed(message: left.message)),
        ifRight: (right) => emit(AddFavoriteItemSuccess()),
      );
    } else {
      emit(const AddFavoriteItemFailed(message: 'Menu data is empty'));
    }
  }
}
