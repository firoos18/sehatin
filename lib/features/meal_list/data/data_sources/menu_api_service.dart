import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/features/meal_list/data/models/menu_model.dart';

class MenuApiService {
  final FirebaseFirestore _firebaseFirestore;

  const MenuApiService(this._firebaseFirestore);

  Future<List<MenuModel>> getMenus() async {
    try {
      final QuerySnapshot response =
          await _firebaseFirestore.collection('menus').get();

      return response.docs
          .map((menu) => MenuModel.fromDocumentSnapshot(menu))
          .toList();
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
    }
  }

  Future<MenuModel> getMenu(String? id) async {
    try {
      final DocumentSnapshot response =
          await _firebaseFirestore.collection('menus').doc(id).get();

      return MenuModel.fromDocumentSnapshot(response);
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
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
