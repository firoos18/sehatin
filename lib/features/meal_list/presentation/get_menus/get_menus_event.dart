part of 'get_menus_bloc.dart';

sealed class GetMenusEvent extends Equatable {
  const GetMenusEvent();

  @override
  List<Object> get props => [];
}

final class GetMenus extends GetMenusEvent {}
