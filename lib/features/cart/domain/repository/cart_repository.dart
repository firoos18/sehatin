import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/cart/data/models/cart_items_model.dart';
import 'package:sehatin/features/cart/data/models/cart_model.dart';
import 'package:sehatin/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failures, CartEntity>> getCart();

  Future<Either<Failures, void>> addCartItem(CartModel cartModel);

  Future<Either<Failures, void>> updateCartItem(CartItemsModel cartItemsModel);

  Future<Either<Failures, void>> deleteCartItem(String? itemId);
}
