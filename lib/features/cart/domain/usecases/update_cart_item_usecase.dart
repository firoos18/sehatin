import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/cart/data/models/cart_items_model.dart';
import 'package:sehatin/features/cart/domain/repository/cart_repository.dart';

class UpdateCartItemUseCase
    implements UseCase<Either<Failures, void>, CartItemsModel> {
  final CartRepository cartRepository;

  const UpdateCartItemUseCase(this.cartRepository);

  @override
  Future<Either<Failures, void>> call({CartItemsModel? params}) async {
    return await cartRepository.updateCartItem(params!);
  }
}
