import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/auth/data/models/auth_model.dart';
import 'package:sehatin/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failures, UserEntity>> login(AuthModel loginData);

  Future<Either<Failures, UserEntity>> register(AuthModel loginData);

  Either<Failures, UserEntity> getUser();
}
