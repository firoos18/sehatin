part of 'menu_by_id_bloc.dart';

sealed class MenuByIdEvent extends Equatable {
  final String? id;

  const MenuByIdEvent({this.id});

  @override
  List<Object?> get props => [id];
}

final class GetMenuById extends MenuByIdEvent {
  const GetMenuById({super.id});
}
