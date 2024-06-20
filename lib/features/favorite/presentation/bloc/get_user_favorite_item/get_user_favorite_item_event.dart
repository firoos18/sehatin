part of 'get_user_favorite_item_bloc.dart';

sealed class GetUserFavoriteItemEvent extends Equatable {
  const GetUserFavoriteItemEvent();

  @override
  List<Object> get props => [];
}

final class GetUserFavoriteItem extends GetUserFavoriteItemEvent {}
