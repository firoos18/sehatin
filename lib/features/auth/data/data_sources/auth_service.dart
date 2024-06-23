import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/features/auth/data/models/auth_model.dart';
import 'package:sehatin/features/auth/data/models/user_model.dart';
import 'package:sehatin/features/cart/data/data_sources/cart_api_service.dart';
import 'package:sehatin/features/cart/data/models/cart_model.dart';
import 'package:sehatin/features/favorite/data/data_sources/favorite_api_service.dart';
import 'package:sehatin/features/favorite/data/models/favorite_item_model.dart';

class AuthService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final CartApiService _cartApiService;
  final FavoriteApiService _favoriteApiService;

  const AuthService(
    this.firebaseAuth,
    this.firebaseFirestore,
    this._cartApiService,
    this._favoriteApiService,
  );

  Future<UserModel> login(AuthModel loginData) async {
    try {
      final UserCredential response =
          await firebaseAuth.signInWithEmailAndPassword(
        email: loginData.email!,
        password: loginData.password!,
      );

      if (response.user != null) {
        return UserModel.fromFirebaseAuthUser(response.user!);
      } else {
        throw RequestErrorException('Error While Singing In User');
      }
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  Future<UserModel> register(AuthModel registerData) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: registerData.email!,
        password: registerData.password!,
      );

      if (response.user != null) {
        await _cartApiService
            .addCart(CartModel(items: const [], uid: response.user!.uid));
        await _favoriteApiService.addFavorite(
            FavoriteItemModel(items: const [], uid: response.user!.uid));

        return UserModel.fromFirebaseAuthUser(response.user!);
      } else {
        throw RequestErrorException('Error While Registering User');
      }
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  UserModel getUser() {
    final response = firebaseAuth.currentUser;

    if (response != null) {
      return UserModel.fromFirebaseAuthUser(response);
    } else {
      throw RequestErrorException('Error While Getting User');
    }
  }

  Future<void> userLogOut() async {
    try {
      final response = await firebaseAuth.signOut();
      return response;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  RequestErrorException _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return RequestErrorException('No user found for that email.');
      case 'wrong-password':
        return RequestErrorException('Wrong password provided.');
      case 'email-already-in-use':
        return RequestErrorException(
            'The account already exists for that email.');
      case 'invalid-email':
        return RequestErrorException('The email address is not valid.');
      default:
        return RequestErrorException('Authentication error: ${e.message}');
    }
  }
}
