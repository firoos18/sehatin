part of 'add_favorite_item_bloc.dart';

sealed class AddFavoriteItemEvent extends Equatable {
  final MenuModel? menuModel;

  const AddFavoriteItemEvent({this.menuModel});

  @override
  List<Object?> get props => [menuModel];
}

final class AddItemToFavoriteButtonTapped extends AddFavoriteItemEvent {
  const AddItemToFavoriteButtonTapped({super.menuModel});
}
