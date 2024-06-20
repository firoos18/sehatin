part of 'add_item_to_history_bloc.dart';

sealed class AddItemToHistoryEvent extends Equatable {
  const AddItemToHistoryEvent();

  @override
  List<Object> get props => [];
}

final class ProceedPaymentButtonTapped extends AddItemToHistoryEvent {}
