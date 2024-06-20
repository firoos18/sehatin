import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/features/cart/data/models/cart_items_model.dart';
import 'package:sehatin/features/cart/data/models/cart_model.dart';

class CartApiService {
  final FirebaseFirestore _firebaseFirestore;

  const CartApiService(this._firebaseFirestore);

  Future<CartModel> getCart(String? uid) async {
    try {
      final response = await _firebaseFirestore
          .collection('cart')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (response.docs.isNotEmpty) {
        return response.docs
            .map((cart) => CartModel.fromDocumentSnapshot(cart))
            .first;
      } else {
        throw RequestErrorException('Cart not found for the given UID.');
      }
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
    }
  }

  Future<void> addCart(CartModel cartModel) async {
    try {
      await _firebaseFirestore.collection('cart').add(cartModel.toMap());
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
    }
  }

  Future<void> addItemToCart(CartItemsModel newItem, String uid) async {
    try {
      final cartQuery = await _firebaseFirestore
          .collection('cart')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (cartQuery.docs.isEmpty) {
        throw RequestErrorException('Cart not found for the given UID.');
      }

      final cartDoc = cartQuery.docs.first;
      final cartData = cartDoc.data();
      final List<dynamic> items = cartData['items'] ?? [];

      bool itemExists = false;

      List<CartItemsModel> cartItems = items.map((item) {
        return CartItemsModel.fromMap(item as Map<String, dynamic>);
      }).toList();

      for (int i = 0; i < cartItems.length; i++) {
        if (cartItems[i].menu!.id == newItem.menu!.id) {
          itemExists = true;

          cartItems[i] = CartItemsModel(
            menu: cartItems[i].menu,
            quantity: (cartItems[i].quantity ?? 0) + (newItem.quantity ?? 0),
          );
          break;
        }
      }

      if (!itemExists) {
        cartItems.add(newItem);
      }

      final updatedItems = cartItems.map((item) => item.toMap()).toList();

      await _firebaseFirestore
          .collection('cart')
          .doc(cartDoc.id)
          .update({'items': updatedItems});
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
    } catch (e) {
      throw RequestErrorException('Unexpected error: $e');
    }
  }

  Future<void> deleteItemFromCart(String itemId, String uid) async {
    try {
      final cart = await _firebaseFirestore
          .collection('cart')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (cart.docs.isNotEmpty) {
        final cartDoc = cart.docs.first;
        final cartItems = cartDoc.data()['items'] as List;

        final updatedItems =
            cartItems.where((item) => item['menu']['id'] != itemId).toList();

        await _firebaseFirestore.collection('cart').doc(cartDoc.id).update({
          'items': updatedItems,
        });
      } else {
        throw RequestErrorException('Cart not found for the given UID.');
      }
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
    } catch (e) {
      throw RequestErrorException('Unexpected error: $e');
    }
  }
}

RequestErrorException _handleFirebaseException(FirebaseException e) {
  switch (e.code) {
    case 'permission-denied':
      return RequestErrorException('Permission denied.');
    case 'unavailable':
      return RequestErrorException('Service currently unavailable.');
    // Add more cases as needed
    default:
      return RequestErrorException('Firestore error: ${e.message}');
  }
}
