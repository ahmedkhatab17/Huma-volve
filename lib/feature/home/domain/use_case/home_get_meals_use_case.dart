import 'package:dartz/dartz.dart';
import 'package:recipy_app_offline/core/error/failure.dart';
import 'package:recipy_app_offline/feature/home/domain/entity/home_meal_entity.dart';
import 'package:recipy_app_offline/feature/home/domain/repository/home_repository.dart';

class HomeGetMealsUseCase {
  final HomeRepository repository;
  const HomeGetMealsUseCase(this.repository);

  Future<Either<Failure, (List<MealEntity>, bool)>> invoke(String category) {
    return repository.getMealsByCategory(category);
  }
}
