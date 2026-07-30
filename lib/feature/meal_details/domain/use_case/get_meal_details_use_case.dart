import 'package:dartz/dartz.dart';
import 'package:reciepe_app/core/error/failure.dart';
import 'package:reciepe_app/feature/meal_details/domain/entity/meal_detail_entity.dart';
import 'package:reciepe_app/feature/meal_details/domain/repository/meal_details_repository.dart';

class GetMealDetailsUseCase {
  final MealDetailsRepository repository;
  GetMealDetailsUseCase(this.repository);

  Future<Either<Failure, MealDetailEntity>> invoke(String mealId) async {
    return await repository.getMealDetails(mealId);
  }
}
