import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatin/features/cart/data/models/cart_items_model.dart';
import 'package:sehatin/features/history/domain/entities/history_item_entity.dart';

class HistoryItemModel extends HistoryItemEntity {
  const HistoryItemModel({
    required super.cartItem,
    required super.timestamp,
    required super.uid,
  });

  factory HistoryItemModel.fromMap(Map<String, dynamic> map) {
    return HistoryItemModel(
      uid: map['uid'],
      cartItem: map['cartItem'] != null
          ? List<CartItemsModel>.from(
              (map['cartItem'] as List<dynamic>).map(
                (item) => CartItemsModel.fromMap(item as Map<String, dynamic>),
              ),
            )
          : [],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'cartItem': cartItem.map((item) => item.toMap()).toList(),
      'timestamp': timestamp,
    };
  }

  factory HistoryItemModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return HistoryItemModel.fromMap(data);
  }

  HistoryItemEntity toEntity() {
    return HistoryItemEntity(
      uid: uid,
      cartItem: cartItem,
      timestamp: timestamp,
    );
  }
}
