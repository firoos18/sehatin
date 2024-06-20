import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/favorite/data/data_sources/favorite_api_service.dart';
import 'package:sehatin/features/favorite/domain/entities/favorite_item_entity.dart';
import 'package:sehatin/features/favorite/domain/repository/favorite_repository.dart';
import 'package:sehatin/features/meal_list/data/models/menu_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteApiService _favoriteApiService;
  final FirebaseAuth _firebaseAuth;

  const FavoriteRepositoryImpl(this._favoriteApiService, this._firebaseAuth);

  @override
  Future<Either<Failures, void>> addFavoriteItem(MenuModel items) async {
    try {
      final user = _firebaseAuth.currentUser;

      final result =
          await _favoriteApiService.addItemToFavorite(items, user!.uid);
      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }

  @override
  Future<Either<Failures, FavoriteItemEntity>> getUserFavorite() async {
    try {
      final user = _firebaseAuth.currentUser;

      final result = await _favoriteApiService.getUserFavorite(user!.uid);
      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }

  @override
  Future<Either<Failures, void>> removeItemFromFavorite(String itemId) async {
    try {
      final user = _firebaseAuth.currentUser;

      final result =
          await _favoriteApiService.removeItemFromFavorite(itemId, user!.uid);
      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }
}
