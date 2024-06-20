import 'package:equatable/equatable.dart';

class UserDetailsEntity extends Equatable {
  final String? email;
  final String? name;
  final double? bodyHeight;
  final double? bodyWeight;

  const UserDetailsEntity({
    this.name,
    this.email,
    this.bodyHeight,
    this.bodyWeight,
  });

  @override
  List<Object?> get props => [
        name,
        bodyHeight,
        bodyHeight,
        email,
      ];
}
