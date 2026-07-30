import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_category_entity.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_meal_entity.dart';
import 'package:reciepe_app/feature/home/domain/use_case/home_get_category_use_case.dart';
import 'package:reciepe_app/feature/home/domain/use_case/home_get_meals_use_case.dart';
import 'package:reciepe_app/feature/home/presentation/view_model/recipe_home_state.dart';

class RecipeHomeCubit extends Cubit<RecipeHomeState> {
  // ApiService apiService;
  HomeGetCategoryUseCase homeGetCategoryUseCase;
  HomeGetMealsUseCase homeGetMealsUseCase;
  RecipeHomeCubit(
    this.homeGetCategoryUseCase,
    this.homeGetMealsUseCase,
    super.initialState,
  );

  List<CategoryEntity> _categories = [];
  List<MealEntity> _meals = [];

  Future<void> fetchCategories() async {
    emit(RecipeHomeLoading());
    final result = await homeGetCategoryUseCase.invoke();
    result.fold((failure) => emit(RecipeHomeFailure(failure.errorMessage)), (
      categories,
    ) async {
      _categories = categories;
      emit(RecipeHomeSuccess(_categories, _meals));
      if (categories.isNotEmpty) {
        await getMealsByCategory(categories.first.strCategory);//!!!!!!!!!
      }
    });
  }

  Future<void> getMealsByCategory(String category) async {
    final result = await homeGetMealsUseCase.invoke(category);
    result.fold((failure) => emit(RecipeHomeFailure(failure.errorMessage)), (
      meals,
    ) {
      _meals = meals;
      emit(RecipeHomeSuccess(_categories, _meals));
    });
  }
}
