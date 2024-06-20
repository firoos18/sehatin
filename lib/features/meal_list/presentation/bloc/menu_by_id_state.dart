part of 'menu_by_id_bloc.dart';

sealed class MenuByIdState extends Equatable {
  final MenuEntity? menuEntity;
  final String? message;

  const MenuByIdState({this.menuEntity, this.message});

  @override
  List<Object?> get props => [menuEntity, message];
}

final class MenuByIdInitial extends MenuByIdState {}

final class MenuByIdLoading extends MenuByIdState {}

final class MenuByIdLoaded extends MenuByIdState {
  const MenuByIdLoaded({super.menuEntity});
}

final class MenuByIdFailed extends MenuByIdState {
  const MenuByIdFailed({super.message});
}
