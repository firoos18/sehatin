import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/meal_list/data/data_sources/menu_api_service.dart';
import 'package:sehatin/features/meal_list/data/models/menu_model.dart';
import 'package:sehatin/features/meal_list/domain/entities/menu_entity.dart';
import 'package:sehatin/features/meal_list/domain/repository/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuApiService _menuApiService;

  const MenuRepositoryImpl(this._menuApiService);

  @override
  Future<Either<Failures, MenuModel>> getMenuById(String? id) async {
    try {
      final result = await _menuApiService.getMenu(id);

      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }

  @override
  Future<Either<Failures, List<MenuEntity>>> getMenus() async {
    try {
      final result = await _menuApiService.getMenus();

      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }
}
