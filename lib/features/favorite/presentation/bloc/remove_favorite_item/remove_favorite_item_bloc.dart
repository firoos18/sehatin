import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/favorite/domain/usecases/remove_item_from_favorite_usecase.dart';

part 'remove_favorite_item_event.dart';
part 'remove_favorite_item_state.dart';

class RemoveFavoriteItemBloc
    extends Bloc<RemoveFavoriteItemEvent, RemoveFavoriteItemState> {
  final RemoveItemFromFavoriteUseCase _removeItemFromFavoriteUseCase;

  RemoveFavoriteItemBloc(this._removeItemFromFavoriteUseCase)
      : super(RemoveFavoriteItemInitial()) {
    on<RemoveFavoriteItemEvent>(onRemoveItemButtonTapped);
  }

  void onRemoveItemButtonTapped(RemoveFavoriteItemEvent event,
      Emitter<RemoveFavoriteItemState> emit) async {
    emit(RemoveFavoriteItemLoading());

    final data = await _removeItemFromFavoriteUseCase.favoriteRepository
        .removeItemFromFavorite(event.itemId!);

    data.fold(
      ifLeft: (left) => emit(RemoveFavoriteItemFailed(message: left.message)),
      ifRight: (right) => emit(RemoveFavoriteItemSuccess()),
    );
  }
}
