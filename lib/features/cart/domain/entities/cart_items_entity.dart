import 'package:equatable/equatable.dart';
import 'package:sehatin/features/meal_list/data/models/menu_model.dart';

class CartItemsEntity extends Equatable {
  final MenuModel? menu;
  final int? quantity;

  const CartItemsEntity({required this.menu, required this.quantity});

  @override
  List<Object?> get props => [menu, quantity];
}
