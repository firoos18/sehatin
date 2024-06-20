part of 'delete_cart_item_bloc.dart';

sealed class DeleteCartItemEvent extends Equatable {
  final String? itemId;

  const DeleteCartItemEvent({this.itemId});

  @override
  List<Object?> get props => [itemId];
}

final class DeleteCartItemButtonTapped extends DeleteCartItemEvent {
  const DeleteCartItemButtonTapped({super.itemId});
}
