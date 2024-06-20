part of 'add_cart_item_bloc.dart';

sealed class AddCartItemEvent extends Equatable {
  final CartItemsModel? cartItemsModel;

  const AddCartItemEvent({this.cartItemsModel});

  @override
  List<Object?> get props => [cartItemsModel];
}

final class AddCartItemButtonTapped extends AddCartItemEvent {
  const AddCartItemButtonTapped({super.cartItemsModel});
}
