import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/features/cart/data/models/cart_items_model.dart';
import 'package:sehatin/features/history/data/models/history_item_model.dart';

class HistoryApiService {
  final FirebaseFirestore _firebaseFirestore;

  const HistoryApiService(this._firebaseFirestore);

  Future<void> addCartItemToHistory(String? uid) async {
    try {
      final cart = await _firebaseFirestore
          .collection('cart')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (cart.docs.isNotEmpty) {
        final cartDoc = cart.docs.first;
        final cartData = cartDoc.data();

        final historyItem = HistoryItemModel(
          uid: uid,
          cartItem: (cartData['items'] as List)
              .map((item) => CartItemsModel.fromMap(item))
              .toList(),
          timestamp: DateTime.now(),
        );

        await _firebaseFirestore.collection('history').add(historyItem.toMap());

        await _firebaseFirestore
            .collection('cart')
            .doc(cartDoc.id)
            .update({'items': []});
      } else {
        throw RequestErrorException('Cart not found for the given UID.');
      }
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
    } catch (e) {
      throw RequestErrorException('Unexpected error: $e');
    }
  }

  Future<List<HistoryItemModel>> getUserHistory(String? uid) async {
    try {
      final QuerySnapshot userHistory = await _firebaseFirestore
          .collection('history')
          .where('uid', isEqualTo: uid)
          .get();

      if (userHistory.docs.isNotEmpty) {
        return userHistory.docs.map((doc) {
          final historyItem = HistoryItemModel.fromDocumentSnapshot(doc);

          return historyItem;
        }).toList();
      } else {
        throw RequestErrorException('Cart not found for the given UID.');
      }
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
    } catch (e) {
      print(e);
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
    default:
      return RequestErrorException('Firestore error: ${e.message}');
  }
}
