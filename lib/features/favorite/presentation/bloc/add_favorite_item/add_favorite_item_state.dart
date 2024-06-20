part of 'add_favorite_item_bloc.dart';

sealed class AddFavoriteItemState extends Equatable {
  final String? message;

  const AddFavoriteItemState({this.message});

  @override
  List<Object?> get props => [message];
}

final class AddFavoriteItemInitial extends AddFavoriteItemState {}

final class AddFavoriteItemLoading extends AddFavoriteItemState {}

final class AddFavoriteItemSuccess extends AddFavoriteItemState {}

final class AddFavoriteItemFailed extends AddFavoriteItemState {
  const AddFavoriteItemFailed({super.message});
}
