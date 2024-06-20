import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/history/domain/usecases/add_item_to_history_usecase.dart';

part 'add_item_to_history_event.dart';
part 'add_item_to_history_state.dart';

class AddItemToHistoryBloc
    extends Bloc<AddItemToHistoryEvent, AddItemToHistoryState> {
  final AddItemToHistoryUseCase _addItemToHistoryUseCase;

  AddItemToHistoryBloc(this._addItemToHistoryUseCase)
      : super(AddItemToHistoryInitial()) {
    on<ProceedPaymentButtonTapped>(onProceedPaymentButtonTapped);
  }

  void onProceedPaymentButtonTapped(
      AddItemToHistoryEvent event, Emitter<AddItemToHistoryState> emit) async {
    emit(AddItemToHistoryLoading());

    final data =
        await _addItemToHistoryUseCase.historyRepository.addItemToHistory();

    data.fold(
      ifLeft: (left) => emit(AddItemToHistoryFailed(message: left.message)),
      ifRight: (right) => emit(AddItemToHistorySuccess()),
    );
  }
}
