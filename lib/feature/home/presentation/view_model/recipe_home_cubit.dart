import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipy_app_offline/feature/home/domain/entity/home_category_entity.dart';
import 'package:recipy_app_offline/feature/home/domain/entity/home_meal_entity.dart';
import 'package:recipy_app_offline/feature/home/domain/use_case/home_get_category_use_case.dart';
import 'package:recipy_app_offline/feature/home/domain/use_case/home_get_meals_use_case.dart';
import 'package:recipy_app_offline/feature/home/presentation/view_model/recipe_home_state.dart';

class RecipeHomeCubit extends Cubit<RecipeHomeState> {
  final HomeGetCategoryUseCase _homeGetCategoryUseCase;
  final HomeGetMealsUseCase _homeGetMealsUseCase;

  List<CategoryEntity> _categories = [];
  List<MealEntity> _meals = [];
  bool _isFromCache = false;

  RecipeHomeCubit(
    this._homeGetCategoryUseCase,
    this._homeGetMealsUseCase,
  ) : super(RecipeHomeInitial());

  Future<void> fetchCategories() async {
    emit(RecipeHomeLoading());
    final result = await _homeGetCategoryUseCase.invoke();
    result.fold(
      (failure) => emit(RecipeHomeFailure(failure.errorMessage)),
      (record) async {
        final (categories, isFromCache) = record;
        _categories = categories;
        _isFromCache = isFromCache;
        emit(RecipeHomeSuccess(_categories, _meals, _isFromCache));
        if (categories.isNotEmpty) {
          await getMealsByCategory(categories.first.strCategory);
        }
      },
    );
  }

  Future<void> getMealsByCategory(String category) async {
    final result = await _homeGetMealsUseCase.invoke(category);
    result.fold(
      (failure) {
        // Bug fix: don't replace the whole screen with an error when only meals
        // fail (e.g. user taps a category not yet cached while offline).
        // Keep categories visible and show empty meals instead.
        emit(RecipeHomeSuccess(_categories, const [], _isFromCache));
      },
      (record) {
        final (meals, isFromCache) = record;
        _meals = meals;
        // If either categories OR meals came from cache, mark as cached.
        _isFromCache = _isFromCache || isFromCache;
        emit(RecipeHomeSuccess(_categories, _meals, _isFromCache));
      },
    );
  }
}
