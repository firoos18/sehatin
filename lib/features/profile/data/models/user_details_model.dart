import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatin/features/profile/domain/entities/user_details_entity.dart';

class UserDetailsModel extends UserDetailsEntity {
  const UserDetailsModel({
    super.email,
    super.name,
    super.bodyHeight,
    super.bodyWeight,
  });

  UserDetailsModel toEntity() {
    return UserDetailsModel(
      email: email,
      name: name,
      bodyHeight: bodyHeight,
      bodyWeight: bodyWeight,
    );
  }

  Map<String, dynamic> toFirestoreDocument() {
    return {
      "name": name,
      "bodyHeight": bodyHeight,
      "bodyWeight": bodyWeight,
      "email": email,
    };
  }

  factory UserDetailsModel.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return UserDetailsModel(
      name: data['name'] as String?,
      bodyHeight: data['bodyHeight'] as double?,
      bodyWeight: data['bodyWeight'] as double?,
      email: data['email'] as String?,
    );
  }
}
