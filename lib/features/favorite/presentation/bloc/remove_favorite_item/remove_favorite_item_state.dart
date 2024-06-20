part of 'remove_favorite_item_bloc.dart';

sealed class RemoveFavoriteItemState extends Equatable {
  final String? message;

  const RemoveFavoriteItemState({this.message});

  @override
  List<Object?> get props => [message];
}

final class RemoveFavoriteItemInitial extends RemoveFavoriteItemState {}

final class RemoveFavoriteItemLoading extends RemoveFavoriteItemState {}

final class RemoveFavoriteItemSuccess extends RemoveFavoriteItemState {}

final class RemoveFavoriteItemFailed extends RemoveFavoriteItemState {
  const RemoveFavoriteItemFailed({super.message});
}
