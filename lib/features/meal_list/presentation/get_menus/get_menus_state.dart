part of 'get_menus_bloc.dart';

sealed class GetMenusState extends Equatable {
  final List<MenuEntity>? menuList;
  final String? message;

  const GetMenusState({this.menuList, this.message});

  @override
  List<Object?> get props => [
        menuList,
        message,
      ];
}

final class GetMenusInitial extends GetMenusState {}

final class GetMenusLoading extends GetMenusState {}

final class GetMenusLoaded extends GetMenusState {
  const GetMenusLoaded({super.menuList});
}

final class GetMenusFailed extends GetMenusState {
  const GetMenusFailed({super.message});
}
