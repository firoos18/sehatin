import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatin/features/cart/data/models/cart_items_model.dart';
import 'package:sehatin/features/cart/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({required super.items, required super.uid});

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      uid: map['uid'] as String?,
      items: (map['items'] as List<dynamic>?)
          ?.map((item) => CartItemsModel.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'items': items?.map((item) => (item as CartItemsModel).toMap()).toList(),
    };
  }

  factory CartModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartModel.fromMap(data);
  }

  CartEntity toEntity() {
    return CartEntity(
      uid: uid,
      items: items,
    );
  }
}
