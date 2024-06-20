import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/cart/data/data_sources/cart_api_service.dart';
import 'package:sehatin/features/cart/data/models/cart_items_model.dart';
import 'package:sehatin/features/cart/data/models/cart_model.dart';
import 'package:sehatin/features/cart/domain/entities/cart_entity.dart';
import 'package:sehatin/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartApiService _cartApiService;
  final FirebaseAuth _firebaseAuth;

  const CartRepositoryImpl(this._cartApiService, this._firebaseAuth);

  @override
  Future<Either<Failures, void>> addCartItem(CartModel cartModel) async {
    try {
      final result = await _cartApiService.addCart(cartModel);

      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }

  @override
  Future<Either<Failures, CartEntity>> getCart() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw Left(RequestFailures('User not authenticated.'));
      }

      final result = await _cartApiService.getCart(user.uid);

      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }

  @override
  Future<Either<Failures, void>> updateCartItem(
    CartItemsModel cartItemsModel,
  ) async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw Left(RequestFailures('User not authenticated.'));
      }

      final result =
          await _cartApiService.addItemToCart(cartItemsModel, user.uid);
      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }

  @override
  Future<Either<Failures, void>> deleteCartItem(String? itemId) async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw Left(RequestFailures('User not authenticated.'));
      }

      final result =
          await _cartApiService.deleteItemFromCart(itemId!, user.uid);

      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }
}
