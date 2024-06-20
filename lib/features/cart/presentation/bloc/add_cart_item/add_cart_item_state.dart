part of 'add_cart_item_bloc.dart';

sealed class AddCartItemState extends Equatable {
  final String? message;

  const AddCartItemState({this.message});

  @override
  List<Object?> get props => [message];
}

final class AddCartItemInitial extends AddCartItemState {}

final class AddCartItemLoading extends AddCartItemState {}

final class AddCartItemSuccess extends AddCartItemState {}

final class AddCartItemFailed extends AddCartItemState {
  const AddCartItemFailed({super.message});
}
