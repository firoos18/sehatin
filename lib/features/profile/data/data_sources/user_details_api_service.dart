import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/features/profile/data/models/add_user_details_model.dart';
import 'package:sehatin/features/profile/data/models/user_details_model.dart';

class UserDetailsApiService {
  final FirebaseFirestore _firebaseFirestore;

  const UserDetailsApiService(this._firebaseFirestore);

  Future<void> addUserDetails(
    AddUserDetailsModel addUserDetailsModel,
  ) async {
    try {
      await _firebaseFirestore
          .collection('user-details')
          .doc(addUserDetailsModel.uuid)
          .set(addUserDetailsModel.userDetailsEntity!.toFirestoreDocument());
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
    }
  }

  Future<UserDetailsModel> getUserDetails(String? uuid) async {
    try {
      final response =
          await _firebaseFirestore.collection('user-details').doc(uuid).get();

      return UserDetailsModel.fromDocumentSnapshot(response);
    } on FirebaseException catch (e) {
      throw _handleFirebaseException(e);
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
}
