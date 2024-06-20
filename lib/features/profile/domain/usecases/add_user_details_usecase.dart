import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/profile/data/models/add_user_details_model.dart';
import 'package:sehatin/features/profile/domain/repository/user_details_repository.dart';

class AddUserDetailsUseCase
    implements UseCase<Either<Failures, void>, AddUserDetailsModel> {
  final UserDetailsRepository userDetailsRepository;

  const AddUserDetailsUseCase(this.userDetailsRepository);

  @override
  Future<Either<Failures, void>> call({AddUserDetailsModel? params}) async {
    return await userDetailsRepository.addUserDetails(params!);
  }
}
