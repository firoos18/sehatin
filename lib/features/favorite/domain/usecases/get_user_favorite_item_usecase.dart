import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/favorite/domain/entities/favorite_item_entity.dart';
import 'package:sehatin/features/favorite/domain/repository/favorite_repository.dart';

class GetUserFavoriteItemUseCase
    implements UseCase<Either<Failures, FavoriteItemEntity>, Null> {
  final FavoriteRepository favoriteRepository;

  const GetUserFavoriteItemUseCase(this.favoriteRepository);

  @override
  Future<Either<Failures, FavoriteItemEntity>> call({Null params}) async {
    return await favoriteRepository.getUserFavorite();
  }
}
