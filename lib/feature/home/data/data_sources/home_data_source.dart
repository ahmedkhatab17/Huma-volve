import 'package:recipy_app_offline/feature/home/data/model/category_model.dart';
import 'package:recipy_app_offline/feature/home/data/model/meal_model.dart';

abstract class HomeDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<MealModel>> getMealsByCategory(String category);
}
