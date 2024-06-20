import 'package:sehatin/features/meal_list/domain/entities/nutrition_entity.dart';

class NutritionModel extends NutritionEntity {
  NutritionModel({
    required super.calorie,
    required super.carbs,
    required super.fat,
    required super.fiber,
    required super.protein,
  });

  factory NutritionModel.fromMap(Map<String, dynamic> map) {
    return NutritionModel(
      calorie: map['calorie'],
      carbs: map['carbs'],
      fat: map['fat'],
      fiber: map['fiber'],
      protein: map['protein'],
    );
  }

  static NutritionModel fromEntity(NutritionEntity nutritionEntity) {
    return NutritionModel(
      calorie: nutritionEntity.calorie,
      carbs: nutritionEntity.carbs,
      fat: nutritionEntity.fat,
      fiber: nutritionEntity.fiber,
      protein: nutritionEntity.protein,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'calorie': calorie,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'protein': protein
    };
  }
}
