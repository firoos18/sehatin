import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/cart/domain/entities/cart_entity.dart';
import 'package:sehatin/features/cart/domain/repository/cart_repository.dart';

class GetCartItemUseCase
    implements UseCase<Either<Failures, CartEntity>, Null> {
  final CartRepository cartRepository;

  const GetCartItemUseCase(this.cartRepository);

  @override
  Future<Either<Failures, CartEntity>> call({Null params}) async {
    return await cartRepository.getCart();
  }
}
