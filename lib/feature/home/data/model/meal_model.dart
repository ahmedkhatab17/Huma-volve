import 'package:recipy_app_offline/feature/home/domain/entity/home_meal_entity.dart';

class MealModel {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  const MealModel({
    this.idMeal = '',
    this.strMeal = '',
    this.strMealThumb = '',
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      idMeal: json['idMeal'] as String? ?? '',
      strMeal: json['strMeal'] as String? ?? '',
      strMealThumb: json['strMealThumb'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
    };
  }

  MealEntity toEntity() {
    return MealEntity(
      idMeal: idMeal,
      strMeal: strMeal,
      strMealThumb: strMealThumb,
    );
  }
}
