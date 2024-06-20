import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/cart/domain/entities/cart_entity.dart';
import 'package:sehatin/features/cart/domain/usecases/get_cart_item_usecase.dart';

part 'get_cart_item_event.dart';
part 'get_cart_item_state.dart';

class GetCartItemBloc extends Bloc<GetCartItemEvent, GetCartItemState> {
  final GetCartItemUseCase _getCartItemUseCase;

  GetCartItemBloc(this._getCartItemUseCase) : super(GetCartItemInitial()) {
    on<GetCartItemEvent>(onGetCartItem);
  }

  void onGetCartItem(
      GetCartItemEvent event, Emitter<GetCartItemState> emit) async {
    emit(GetCartItemLoading());

    final data = await _getCartItemUseCase.cartRepository.getCart();

    data.fold(
      ifLeft: (left) => emit(GetCartItemFailed(message: left.message)),
      ifRight: (right) => emit(GetCartItemLoaded(cartEntity: right)),
    );
  }
}
