import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/meal_list/domain/entities/menu_entity.dart';
import 'package:sehatin/features/meal_list/domain/repository/menu_repository.dart';

class GetMenusUsecase
    implements UseCase<Either<Failures, List<MenuEntity>>, Null> {
  final MenuRepository menuRepository;

  const GetMenusUsecase(this.menuRepository);

  @override
  Future<Either<Failures, List<MenuEntity>>> call({Null params}) async {
    return await menuRepository.getMenus();
  }
}
