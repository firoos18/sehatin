import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/profile/data/data_sources/user_details_api_service.dart';
import 'package:sehatin/features/profile/data/models/add_user_details_model.dart';
import 'package:sehatin/features/profile/domain/entities/user_details_entity.dart';
import 'package:sehatin/features/profile/domain/repository/user_details_repository.dart';

class UserDetailsRepositoryImpl implements UserDetailsRepository {
  final UserDetailsApiService _userDetailsApiService;
  final FirebaseAuth _firebaseAuth;

  const UserDetailsRepositoryImpl(
      this._userDetailsApiService, this._firebaseAuth);

  @override
  Future<Either<Failures, void>> addUserDetails(
      AddUserDetailsModel addUserDetailsModel) async {
    try {
      final result =
          await _userDetailsApiService.addUserDetails(addUserDetailsModel);

      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }

  @override
  Future<Either<Failures, UserDetailsEntity>> getUserDetails() async {
    try {
      final user = _firebaseAuth.currentUser;

      final result = await _userDetailsApiService.getUserDetails(user!.uid);

      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }
}
