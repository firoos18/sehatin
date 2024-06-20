import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/favorite/domain/usecases/get_user_favorite_item_usecase.dart';
import 'package:sehatin/features/meal_list/domain/entities/menu_entity.dart';

part 'get_user_favorite_item_event.dart';
part 'get_user_favorite_item_state.dart';

class GetUserFavoriteItemBloc
    extends Bloc<GetUserFavoriteItemEvent, GetUserFavoriteItemState> {
  final GetUserFavoriteItemUseCase _getUserFavoriteItemUseCase;

  GetUserFavoriteItemBloc(this._getUserFavoriteItemUseCase)
      : super(GetUserFavoriteItemInitial()) {
    on<GetUserFavoriteItem>(onGetUserFavoriteItem);
  }

  void onGetUserFavoriteItem(GetUserFavoriteItemEvent event,
      Emitter<GetUserFavoriteItemState> emit) async {
    emit(GetUserFavoriteItemLoading());

    final data =
        await _getUserFavoriteItemUseCase.favoriteRepository.getUserFavorite();

    data.fold(
      ifLeft: (left) => emit(GetUserFavoriteItemFailed(message: left.message)),
      ifRight: (right) => emit(GetUserFavoriteItemLoaded(items: right.items)),
    );
  }
}
