import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/cubit/recipe_home_state.dart';
import 'package:reciepe_app/models/category_model.dart';
import 'package:reciepe_app/services/api_service.dart';

class RecipeHomeCubit extends Cubit<RecipeHomeState> {
  final ApiService apiService;

  // Keep categories in the cubit so they persist across meal loading
  List<CategoryModel> categories = [];

  RecipeHomeCubit(this.apiService) : super(RecipeHomeInitial());

  Future<void> fetchCategories() async {
    emit(RecipeHomeLoading());
    final result = await apiService.getCategories();
    result.fold(
      (failure) => emit(RecipeHomeFailure(failure.errorMessage)),
      (data) {
        categories = data;
        emit(RecipeHomeCategoriesSuccess(data));
      },
    );
  }

  Future<void> fetchMeals(String category) async {
    emit(RecipeHomeLoading());
    final result = await apiService.getMealsByCategory(category);
    result.fold(
      (failure) => emit(RecipeHomeFailure(failure.errorMessage)),
      (meals) => emit(RecipeHomeMealsSuccess(meals)),
    );
  }
}
