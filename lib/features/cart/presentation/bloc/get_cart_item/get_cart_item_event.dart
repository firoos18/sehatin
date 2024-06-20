part of 'get_cart_item_bloc.dart';

sealed class GetCartItemEvent extends Equatable {
  const GetCartItemEvent();

  @override
  List<Object?> get props => [];
}

final class GetCartItem extends GetCartItemEvent {}
