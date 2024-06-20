import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/cart/data/models/cart_items_model.dart';
import 'package:sehatin/features/cart/domain/usecases/update_cart_item_usecase.dart';

part 'add_cart_item_event.dart';
part 'add_cart_item_state.dart';

class AddCartItemBloc extends Bloc<AddCartItemEvent, AddCartItemState> {
  final UpdateCartItemUseCase _updateCartItemUseCase;

  AddCartItemBloc(this._updateCartItemUseCase) : super(AddCartItemInitial()) {
    on<AddCartItemEvent>(onAddCartItemButtonTapped);
  }

  void onAddCartItemButtonTapped(
    AddCartItemEvent event,
    Emitter<AddCartItemState> emit,
  ) async {
    emit(AddCartItemLoading());

    if (event.cartItemsModel != null) {
      final data = await _updateCartItemUseCase.cartRepository
          .updateCartItem(event.cartItemsModel!);

      data.fold(
        ifLeft: (left) => emit(AddCartItemFailed(message: left.message)),
        ifRight: (right) => emit(AddCartItemSuccess()),
      );
    } else {
      emit(const AddCartItemFailed(message: 'Cart Item is Empty'));
    }
  }
}
