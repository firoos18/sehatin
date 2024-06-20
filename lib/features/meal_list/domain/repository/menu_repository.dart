import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/meal_list/domain/entities/menu_entity.dart';

abstract class MenuRepository {
  Future<Either<Failures, List<MenuEntity>>> getMenus();

  Future<Either<Failures, MenuEntity>> getMenuById(String? id);
}
