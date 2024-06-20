part of 'add_item_to_history_bloc.dart';

sealed class AddItemToHistoryState extends Equatable {
  final String? message;

  const AddItemToHistoryState({this.message});

  @override
  List<Object?> get props => [message];
}

final class AddItemToHistoryInitial extends AddItemToHistoryState {}

final class AddItemToHistoryLoading extends AddItemToHistoryState {}

final class AddItemToHistorySuccess extends AddItemToHistoryState {}

final class AddItemToHistoryFailed extends AddItemToHistoryState {
  const AddItemToHistoryFailed({super.message});
}
