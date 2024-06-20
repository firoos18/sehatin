part of 'get_cart_item_bloc.dart';

sealed class GetCartItemState extends Equatable {
  final CartEntity? cartEntity;
  final String? message;

  const GetCartItemState({this.cartEntity, this.message});

  @override
  List<Object?> get props => [message, cartEntity];
}

final class GetCartItemInitial extends GetCartItemState {}

final class GetCartItemLoading extends GetCartItemState {}

final class GetCartItemLoaded extends GetCartItemState {
  const GetCartItemLoaded({super.cartEntity});
}

final class GetCartItemFailed extends GetCartItemState {
  const GetCartItemFailed({super.message});
}
