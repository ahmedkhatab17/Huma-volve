import 'package:reciepe_app/feature/home/data/model/category_model.dart';
import 'package:reciepe_app/feature/home/data/model/meal_model.dart';

abstract class HomeDataSource {
  Future<List<MealModel>> getMealsByCategory(String category);
  Future<List<CategoryModel>> getCategories();
}
