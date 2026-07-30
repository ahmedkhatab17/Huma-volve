import 'package:dartz/dartz.dart';
import 'package:reciepe_app/core/error/failure.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_meal_entity.dart';
import 'package:reciepe_app/feature/home/domain/repository/home_repository.dart';

class HomeGetMealsUseCase {
  final HomeRepository repository;
  HomeGetMealsUseCase(this.repository);
  Future<Either<Failure, List<MealEntity>>> invoke(String category) async {
    return await repository.getMealsByCategory(category);
  }
}
