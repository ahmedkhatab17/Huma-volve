import 'package:recipy_app_offline/feature/home/domain/entity/home_category_entity.dart';
import 'package:recipy_app_offline/feature/home/domain/entity/home_meal_entity.dart';

abstract class RecipeHomeState {}

class RecipeHomeInitial extends RecipeHomeState {}

class RecipeHomeLoading extends RecipeHomeState {}

class RecipeHomeSuccess extends RecipeHomeState {
  final List<CategoryEntity> categories;
  final List<MealEntity> meals;
  final bool isFromCache;

  RecipeHomeSuccess(
    this.categories, [
    this.meals = const [],
    this.isFromCache = false,
  ]);
}

class RecipeHomeFailure extends RecipeHomeState {
  final String errorMessage;
  RecipeHomeFailure(this.errorMessage);
}
