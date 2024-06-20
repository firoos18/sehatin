import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:sehatin/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  factory UserModel.fromFirebaseAuthUser(firebase_auth.User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  const UserModel({
    required super.email,
    required super.id,
    super.name,
    super.photoUrl,
  });

  UserModel toEntity() {
    return UserModel(
      id: id,
      email: email,
      name: name,
      photoUrl: photoUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        photoUrl,
      ];
}
