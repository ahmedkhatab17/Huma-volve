import 'package:reciepe_app/models/category_model.dart';
import 'package:reciepe_app/models/meal_model.dart';

sealed class RecipeHomeState {}

class RecipeHomeInitial extends RecipeHomeState {}

class RecipeHomeLoading extends RecipeHomeState {}

class RecipeHomeFailure extends RecipeHomeState {
  final String errorMessage;
  RecipeHomeFailure(this.errorMessage);
}

class RecipeHomeCategoriesSuccess extends RecipeHomeState {
  final List<CategoryModel> categories;
  RecipeHomeCategoriesSuccess(this.categories);
}

class RecipeHomeMealsSuccess extends RecipeHomeState {
  final List<MealModel> meals;
  RecipeHomeMealsSuccess(this.meals);
}
