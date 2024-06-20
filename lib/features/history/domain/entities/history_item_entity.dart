import 'package:equatable/equatable.dart';
import 'package:sehatin/features/cart/data/models/cart_items_model.dart';

class HistoryItemEntity extends Equatable {
  final String? uid;
  final List<CartItemsModel> cartItem;
  final DateTime timestamp;

  const HistoryItemEntity({
    required this.uid,
    required this.cartItem,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        uid,
        cartItem,
        timestamp,
      ];
}
