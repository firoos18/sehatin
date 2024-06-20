import 'package:equatable/equatable.dart';
import 'package:sehatin/features/meal_list/domain/entities/menu_entity.dart';

class FavoriteItemEntity extends Equatable {
  final String uid;
  final List<MenuEntity> items;

  const FavoriteItemEntity({
    required this.items,
    required this.uid,
  });

  @override
  List<Object?> get props => [uid, items];
}
