import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/cart/domain/usecases/delete_cart_item_usecase.dart';

part 'delete_cart_item_event.dart';
part 'delete_cart_item_state.dart';

class DeleteCartItemBloc
    extends Bloc<DeleteCartItemEvent, DeleteCartItemState> {
  final DeleteCartItemUseCase _deleteCartItemUseCase;

  DeleteCartItemBloc(this._deleteCartItemUseCase)
      : super(DeleteCartItemInitial()) {
    on<DeleteCartItemButtonTapped>(onDeleteCartItemButtonTapped);
  }

  void onDeleteCartItemButtonTapped(
      DeleteCartItemEvent event, Emitter<DeleteCartItemState> emit) async {
    emit(DeleteCartItemLoading());

    final data = await _deleteCartItemUseCase.cartRepository
        .deleteCartItem(event.itemId);

    data.fold(
      ifLeft: (left) => emit(DeleteCartItemFailed(message: left.message)),
      ifRight: (right) => emit(DeleteCartItemSuccess()),
    );
  }
}
