import 'package:equatable/equatable.dart';
import 'package:sehatin/features/meal_list/data/models/nutrition_model.dart';

class MenuEntity extends Equatable {
  final String? id;
  final String? name;
  final String? toppings;
  final double? ratings;
  final int? price;
  final String? image;
  final String? category;
  final String? description;
  final NutritionModel? nutrition;

  const MenuEntity({
    required this.id,
    required this.category,
    required this.image,
    required this.name,
    required this.price,
    required this.ratings,
    required this.toppings,
    required this.description,
    required this.nutrition,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        toppings,
        ratings,
        price,
        image,
        category,
        description,
        nutrition,
      ];
}
