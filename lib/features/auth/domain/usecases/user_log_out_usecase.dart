import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/auth/domain/repository/auth_repository.dart';

class UserLogOutUseCase implements UseCase<Either<Failures, void>, Null> {
  final AuthRepository authRepository;

  const UserLogOutUseCase(this.authRepository);

  @override
  Future<Either<Failures, void>> call({Null params}) async {
    return await authRepository.logout();
  }
}
