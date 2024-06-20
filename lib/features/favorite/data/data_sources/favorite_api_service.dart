import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/features/favorite/data/models/favorite_item_model.dart';
import 'package:sehatin/features/meal_list/data/models/menu_model.dart';

class FavoriteApiService {
  final FirebaseFirestore _firebaseFirestore;

  const FavoriteApiService(this._firebaseFirestore);

  Future<void> addFavorite(FavoriteItemModel favoriteItemModel) async {
    try {
      await _firebaseFirestore
          .collection('favorite')
          .add(favoriteItemModel.toMap());
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
    }
  }

  Future<void> addItemToFavorite(MenuModel menuModel, String uid) async {
    try {
      final favoriteQuery = await _firebaseFirestore
          .collection('favorite')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (favoriteQuery.docs.isEmpty) {
        throw RequestErrorException('Favorite not found for the given UID.');
      }

      final favoriteDoc = favoriteQuery.docs.first;
      final favoriteData = favoriteDoc.data();
      List<dynamic> items = favoriteData['items'] ?? [];

      bool itemExists = false;

      List<MenuModel> favoriteItems = items.map((item) {
        return MenuModel.fromMap(item as Map<String, dynamic>);
      }).toList();

      for (var favoriteItem in favoriteItems) {
        if (favoriteItem.id == menuModel.id) {
          itemExists = true;
          break;
        }
      }

      if (itemExists) {
        throw 'Item already added to favorite.';
      }

      favoriteItems.add(menuModel);

      final updatedItems = favoriteItems.map((item) => item.toMap()).toList();

      await _firebaseFirestore
          .collection('favorite')
          .doc(favoriteDoc.id)
          .update({'items': updatedItems});
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
    } catch (e) {
      throw RequestErrorException('$e');
    }
  }

  Future<FavoriteItemModel> getUserFavorite(String? uid) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('favorite')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return FavoriteItemModel.fromDocumentSnapshot(doc);
      } else {
        throw RequestErrorException('No favorites found for the given UID');
      }
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
    }
  }

  Future<void> removeItemFromFavorite(String itemId, String uid) async {
    try {
      final favoriteQuery = await _firebaseFirestore
          .collection('favorite')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (favoriteQuery.docs.isEmpty) {
        throw RequestErrorException('Favorite not found for the given UID.');
      }

      final favoriteDoc = favoriteQuery.docs.first;
      final favoriteData = favoriteDoc.data();
      List<dynamic> items = favoriteData['items'] ?? [];

      List<MenuModel> favoriteItems = items.map((item) {
        return MenuModel.fromMap(item as Map<String, dynamic>);
      }).toList();

      favoriteItems.removeWhere((item) => item.id == itemId);

      final updatedItems = favoriteItems.map((item) => item.toMap()).toList();

      await _firebaseFirestore
          .collection('favorite')
          .doc(favoriteDoc.id)
          .update({'items': updatedItems});
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
    default:
      return RequestErrorException('Firestore error: ${e.message}');
  }
}
