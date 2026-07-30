import 'package:reciepe_app/feature/meal_details/domain/entity/meal_detail_entity.dart';

class Ingredient {
  final String name;
  final String measure;

  Ingredient({required this.name, required this.measure});

  IngredientEntity toEntity() {
    return IngredientEntity(name: name, measure: measure);
  }
}

class MealDetailModel {
  String? idMeal;
  String? strMeal;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String? strMealThumb;
  String? strTags;
  String? strYoutube;
  String? strSource;
  List<Ingredient> ingredients;

  MealDetailModel({
    this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strSource,
    this.ingredients = const [],
  });

  MealDetailModel.fromJson(Map<String, dynamic> json) : ingredients = const [] {
    List<Ingredient> extractedIngredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        extractedIngredients.add(
          Ingredient(
            name: ingredient.toString().trim(),
            measure: measure != null ? measure.toString().trim() : '',
          ),
        );
      }
    }
    idMeal = json['idMeal'];
    strMeal = json['strMeal'];
    strCategory = json['strCategory'];
    strArea = json['strArea'];
    strInstructions = json['strInstructions'];
    strMealThumb = json['strMealThumb'];
    strTags = json['strTags'];
    strYoutube = json['strYoutube'];
    strSource = json['strSource'];
    ingredients = extractedIngredients;
  }

  MealDetailEntity toEntity() {
    return MealDetailEntity(
      idMeal: idMeal ?? '',
      strMeal: strMeal ?? '',
      strCategory: strCategory ?? '',
      strArea: strArea ?? '',
      strInstructions: strInstructions ?? '',
      strMealThumb: strMealThumb ?? '',
      strTags: strTags ?? '',
      strYoutube: strYoutube ?? '',
      strSource: strSource ?? '',
      ingredients: ingredients.map((ingredient) => ingredient.toEntity()).toList(),
    );
  }
}
