part of 'get_user_history_bloc.dart';

sealed class GetUserHistoryEvent extends Equatable {
  const GetUserHistoryEvent();

  @override
  List<Object> get props => [];
}

final class GetUserHistory extends GetUserHistoryEvent {}
