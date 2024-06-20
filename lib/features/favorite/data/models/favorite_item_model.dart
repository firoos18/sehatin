import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatin/features/favorite/domain/entities/favorite_item_entity.dart';
import 'package:sehatin/features/meal_list/data/models/menu_model.dart';

class FavoriteItemModel extends FavoriteItemEntity {
  const FavoriteItemModel({required super.items, required super.uid});

  factory FavoriteItemModel.fromMap(Map<String, dynamic> map) {
    return FavoriteItemModel(
      uid: map['uid'],
      items: (map['items'] as List<dynamic>)
          .map((item) => MenuModel.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  factory FavoriteItemModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteItemModel.fromMap(data);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'items': items.map((item) => (item as MenuModel).toMap()).toList(),
    };
  }

  FavoriteItemEntity toEntity() {
    return FavoriteItemEntity(
      uid: uid,
      items: items,
    );
  }
}
