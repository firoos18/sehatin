import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/auth/domain/entities/user_entity.dart';
import 'package:sehatin/features/auth/domain/repository/auth_repository.dart';

class GetUserUseCase implements UseCase<Either<Failures, UserEntity>, Null> {
  final AuthRepository authRepository;

  const GetUserUseCase(this.authRepository);

  @override
  Future<Either<Failures, UserEntity>> call({Null params}) async {
    return authRepository.getUser();
  }
}
