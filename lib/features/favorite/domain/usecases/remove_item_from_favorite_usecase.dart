import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/favorite/domain/repository/favorite_repository.dart';

class RemoveItemFromFavoriteUseCase
    implements UseCase<Either<Failures, void>, String> {
  final FavoriteRepository favoriteRepository;

  const RemoveItemFromFavoriteUseCase(this.favoriteRepository);

  @override
  Future<Either<Failures, void>> call({String? params}) async {
    return await favoriteRepository.removeItemFromFavorite(params!);
  }
}
