part of 'remove_favorite_item_bloc.dart';

sealed class RemoveFavoriteItemEvent extends Equatable {
  final String? itemId;

  const RemoveFavoriteItemEvent({this.itemId});

  @override
  List<Object?> get props => [itemId];
}

final class RemoveItemButtonTapped extends RemoveFavoriteItemEvent {
  const RemoveItemButtonTapped({super.itemId});
}
