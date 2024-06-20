import 'package:equatable/equatable.dart';
import 'package:sehatin/features/cart/domain/entities/cart_items_entity.dart';

class CartEntity extends Equatable {
  final String? uid;
  final List<CartItemsEntity>? items;

  const CartEntity({required this.items, required this.uid});

  @override
  List<Object?> get props => [uid, items];
}
