import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/meal_list/domain/entities/menu_entity.dart';
import 'package:sehatin/features/meal_list/domain/repository/menu_repository.dart';

class GetMenuByIdUseCase
    implements UseCase<Either<Failures, MenuEntity>, String?> {
  final MenuRepository menuRepository;

  const GetMenuByIdUseCase(this.menuRepository);

  @override
  Future<Either<Failures, MenuEntity>> call({String? params}) async {
    return await menuRepository.getMenuById(params);
  }
}
