import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/auth/data/data_sources/auth_service.dart';
import 'package:sehatin/features/auth/data/models/auth_model.dart';
import 'package:sehatin/features/auth/data/models/user_model.dart';
import 'package:sehatin/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  const AuthRepositoryImpl(this.authService);

  @override
  Future<Either<Failures, UserModel>> login(AuthModel loginData) async {
    try {
      final userData = await authService.login(loginData);

      return Right(userData.toEntity());
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }

  @override
  Future<Either<Failures, UserModel>> register(AuthModel registerData) async {
    try {
      final userData = await authService.register(registerData);

      return Right(userData.toEntity());
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }

  @override
  Either<Failures, UserModel> getUser() {
    try {
      final userData = authService.getUser();

      return Right(userData);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }

  @override
  Future<Either<Failures, void>> logout() async {
    try {
      final result = await authService.userLogOut();

      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }
}
