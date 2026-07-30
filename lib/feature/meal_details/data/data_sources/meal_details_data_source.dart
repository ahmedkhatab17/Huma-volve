import 'package:reciepe_app/feature/meal_details/data/model/meal_detail_model.dart';

abstract class MealDetailsDataSource {
  Future<MealDetailModel> getMealDetails(String mealId);
}
