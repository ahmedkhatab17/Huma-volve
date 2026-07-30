import 'package:reciepe_app/feature/home/domain/entity/home_meal_entity.dart';

class MealModel {
  String? idMeal;
  String? strMeal;
  String? strMealThumb;

  MealModel({this.idMeal, this.strMeal, this.strMealThumb});

  MealModel.fromJson(Map<String, dynamic> json) {
    idMeal = json['idMeal'];
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
  }

  MealEntity toEntity() {
    return MealEntity(
      idMeal: idMeal ?? '',
      strMeal: strMeal ?? '',
      strMealThumb: strMealThumb ?? '',
    );
  }
}
