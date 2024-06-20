import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehatin/features/meal_list/data/models/nutrition_model.dart';
import 'package:sehatin/features/meal_list/domain/entities/menu_entity.dart';

class MenuModel extends MenuEntity {
  const MenuModel({
    required super.id,
    required super.category,
    required super.image,
    required super.name,
    required super.price,
    required super.ratings,
    required super.toppings,
    required super.description,
    required super.nutrition,
  });

  factory MenuModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return MenuModel(
      id: documentSnapshot.id,
      category: documentSnapshot['category'] as String?,
      image: documentSnapshot['image'] as String,
      name: documentSnapshot['name'] as String?,
      price: int.parse(documentSnapshot['price']),
      ratings: double.parse(documentSnapshot['ratings']),
      toppings: documentSnapshot['toppings'] as String?,
      description: documentSnapshot['description'] as String?,
      nutrition: documentSnapshot['nutrition'] != null
          ? NutritionModel.fromMap(
              documentSnapshot['nutrition'] as Map<String, dynamic>)
          : null,
    );
  }

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      id: map['id'] as String,
      category: map['category'] as String?,
      image: map['image'] as String,
      name: map['name'] as String?,
      price: map['price'] as int,
      ratings: map['ratings'] as double,
      toppings: map['toppings'] as String?,
      description: map['description'] as String?,
      nutrition: map['nutrition'] != null
          ? NutritionModel.fromMap(map['nutrition'] as Map<String, dynamic>)
          : null,
    );
  }

  static MenuModel fromEntity(MenuEntity entity) {
    return MenuModel(
      id: entity.id,
      category: entity.category,
      image: entity.image,
      name: entity.name,
      price: entity.price,
      ratings: entity.ratings,
      toppings: entity.toppings,
      description: entity.description,
      nutrition: entity.nutrition != null
          ? NutritionModel.fromEntity(entity.nutrition!)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'image': image,
      'name': name,
      'price': price,
      'ratings': ratings,
      'toppings': toppings,
      'description': description,
      'nutrition': nutrition?.toMap(), // Convert NutritionModel to Map
    };
  }
}
