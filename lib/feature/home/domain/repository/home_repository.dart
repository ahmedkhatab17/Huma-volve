import 'package:dartz/dartz.dart';
import 'package:reciepe_app/core/error/failure.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_category_entity.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_meal_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<MealEntity>>> getMealsByCategory(String category);
}
