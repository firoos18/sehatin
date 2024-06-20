import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/favorite/domain/repository/favorite_repository.dart';
import 'package:sehatin/features/meal_list/data/models/menu_model.dart';

class AddFavoriteItemUseCase
    implements UseCase<Either<Failures, void>, MenuModel> {
  final FavoriteRepository favoriteRepository;

  const AddFavoriteItemUseCase(this.favoriteRepository);

  @override
  Future<Either<Failures, void>> call({MenuModel? params}) async {
    return await favoriteRepository.addFavoriteItem(params!);
  }
}
