part of 'get_user_favorite_item_bloc.dart';

sealed class GetUserFavoriteItemState extends Equatable {
  final List<MenuEntity>? items;
  final String? message;

  const GetUserFavoriteItemState({this.items, this.message});

  @override
  List<Object?> get props => [items, message];
}

final class GetUserFavoriteItemInitial extends GetUserFavoriteItemState {}

final class GetUserFavoriteItemLoading extends GetUserFavoriteItemState {}

final class GetUserFavoriteItemLoaded extends GetUserFavoriteItemState {
  const GetUserFavoriteItemLoaded({super.items});
}

final class GetUserFavoriteItemFailed extends GetUserFavoriteItemState {
  const GetUserFavoriteItemFailed({super.message});
}
