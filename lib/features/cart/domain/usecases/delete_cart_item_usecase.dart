import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/cart/domain/repository/cart_repository.dart';

class DeleteCartItemUseCase implements UseCase<Either<Failures, void>, String> {
  final CartRepository cartRepository;

  const DeleteCartItemUseCase(this.cartRepository);

  @override
  Future<Either<Failures, void>> call({String? params}) async {
    return await cartRepository.deleteCartItem(params);
  }
}
