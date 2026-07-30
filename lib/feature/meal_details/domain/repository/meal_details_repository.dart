import 'package:dartz/dartz.dart';
import 'package:reciepe_app/core/error/failure.dart';
import 'package:reciepe_app/feature/meal_details/domain/entity/meal_detail_entity.dart';

abstract class MealDetailsRepository {
  Future<Either<Failure, MealDetailEntity>> getMealDetails(String mealId);
}
