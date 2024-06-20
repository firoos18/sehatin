part of 'get_user_history_bloc.dart';

sealed class GetUserHistoryState extends Equatable {
  final List<HistoryItemEntity>? historyItemEntity;
  final String? message;

  const GetUserHistoryState({this.historyItemEntity, this.message});

  @override
  List<Object?> get props => [historyItemEntity, message];
}

final class GetUserHistoryInitial extends GetUserHistoryState {}

final class GetUserHistoryLoading extends GetUserHistoryState {}

final class GetUserHistoryLoaded extends GetUserHistoryState {
  const GetUserHistoryLoaded({super.historyItemEntity});
}

final class GetUserHistoryFailed extends GetUserHistoryState {
  const GetUserHistoryFailed({super.message});
}
