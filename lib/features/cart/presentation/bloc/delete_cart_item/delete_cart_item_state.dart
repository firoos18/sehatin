part of 'delete_cart_item_bloc.dart';

sealed class DeleteCartItemState extends Equatable {
  final String? message;

  const DeleteCartItemState({this.message});

  @override
  List<Object?> get props => [message];
}

final class DeleteCartItemInitial extends DeleteCartItemState {}

final class DeleteCartItemLoading extends DeleteCartItemState {}

final class DeleteCartItemSuccess extends DeleteCartItemState {}

final class DeleteCartItemFailed extends DeleteCartItemState {
  const DeleteCartItemFailed({super.message});
}
