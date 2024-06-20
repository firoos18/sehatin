import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/profile/domain/entities/user_details_entity.dart';
import 'package:sehatin/features/profile/domain/repository/user_details_repository.dart';

class GetUserDetailsUseCase
    implements UseCase<Either<Failures, UserDetailsEntity>, Null> {
  final UserDetailsRepository userDetailsRepository;

  const GetUserDetailsUseCase(this.userDetailsRepository);

  @override
  Future<Either<Failures, UserDetailsEntity>> call({Null params}) async {
    return await userDetailsRepository.getUserDetails();
  }
}
