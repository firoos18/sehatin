import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sehatin/features/history/domain/entities/history_item_entity.dart';
import 'package:sehatin/features/history/domain/usecases/get_user_history_usecase.dart';

part 'get_user_history_event.dart';
part 'get_user_history_state.dart';

class GetUserHistoryBloc
    extends Bloc<GetUserHistoryEvent, GetUserHistoryState> {
  final GetUserHistoryUseCase _getUserHistoryUseCase;

  GetUserHistoryBloc(this._getUserHistoryUseCase)
      : super(GetUserHistoryInitial()) {
    on<GetUserHistory>(onGetUserHistory);
  }

  void onGetUserHistory(
      GetUserHistoryEvent event, Emitter<GetUserHistoryState> emit) async {
    emit(GetUserHistoryLoading());

    final data =
        await _getUserHistoryUseCase.historyRepository.getUserHistory();

    data.fold(
      ifLeft: (left) => emit(GetUserHistoryFailed(message: left.message)),
      ifRight: (right) => emit(GetUserHistoryLoaded(historyItemEntity: right)),
    );
  }
}
