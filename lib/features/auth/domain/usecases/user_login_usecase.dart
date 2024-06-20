import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/auth/data/models/auth_model.dart';
import 'package:sehatin/features/auth/domain/entities/user_entity.dart';
import 'package:sehatin/features/auth/domain/repository/auth_repository.dart';

class UserLoginUsecase
    implements UseCase<Either<Failures, UserEntity>, AuthModel> {
  final AuthRepository authRepository;

  const UserLoginUsecase(this.authRepository);

  @override
  Future<Either<Failures, UserEntity>> call({AuthModel? params}) async {
    return await authRepository.login(params!);
  }
}
