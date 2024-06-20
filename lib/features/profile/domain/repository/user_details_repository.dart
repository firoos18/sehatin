import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/profile/data/models/add_user_details_model.dart';
import 'package:sehatin/features/profile/domain/entities/user_details_entity.dart';

abstract class UserDetailsRepository {
  Future<Either<Failures, void>> addUserDetails(
    AddUserDetailsModel addUserDetailsModel,
  );

  Future<Either<Failures, UserDetailsEntity>> getUserDetails();
}
