import 'package:dartz/dartz.dart';
import 'package:recipy_app_offline/core/error/failure.dart';
import 'package:recipy_app_offline/feature/home/domain/entity/home_category_entity.dart';
import 'package:recipy_app_offline/feature/home/domain/entity/home_meal_entity.dart';

abstract class HomeRepository {
  /// Returns (data, isFromCache) — true when served from Hive instead of network.
  Future<Either<Failure, (List<CategoryEntity>, bool)>> getCategories();
  Future<Either<Failure, (List<MealEntity>, bool)>> getMealsByCategory(
      String category);
}
