import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/favorite/domain/entities/favorite_item_entity.dart';
import 'package:sehatin/features/meal_list/data/models/menu_model.dart';

abstract class FavoriteRepository {
  Future<Either<Failures, void>> addFavoriteItem(MenuModel items);

  Future<Either<Failures, FavoriteItemEntity>> getUserFavorite();

  Future<Either<Failures, void>> removeItemFromFavorite(String itemId);
}
