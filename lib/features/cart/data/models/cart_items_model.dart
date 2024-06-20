import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatin/features/cart/domain/entities/cart_items_entity.dart';
import 'package:sehatin/features/meal_list/data/models/menu_model.dart';

class CartItemsModel extends CartItemsEntity {
  const CartItemsModel({required super.menu, required super.quantity});

  factory CartItemsModel.fromMap(Map<String, dynamic> map) {
    return CartItemsModel(
      menu: map['menu'] != null
          ? MenuModel.fromMap(map['menu'] as Map<String, dynamic>)
          : null,
      quantity: map['quantity'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'menu': menu!.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItemsModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartItemsModel.fromMap(data);
  }

  CartItemsEntity toEntity() {
    return CartItemsEntity(
      menu: menu,
      quantity: quantity,
    );
  }
}
