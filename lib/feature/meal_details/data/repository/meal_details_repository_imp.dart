import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciepe_app/core/error/error_handler.dart';
import 'package:reciepe_app/core/error/failure.dart';
import 'package:reciepe_app/feature/meal_details/data/data_sources/meal_details_data_source.dart';
import 'package:reciepe_app/feature/meal_details/domain/entity/meal_detail_entity.dart';
import 'package:reciepe_app/feature/meal_details/domain/repository/meal_details_repository.dart';

class MealDetailsRepositoryImp implements MealDetailsRepository {
  final MealDetailsDataSource dataSource;
  MealDetailsRepositoryImp(this.dataSource);

  @override
  Future<Either<Failure, MealDetailEntity>> getMealDetails(String mealId) async {
    try {
      final response = await dataSource.getMealDetails(mealId);
      return right(response.toEntity());
    } on DioException catch (e) {
      return left(HandleError.handle(e));
    }
  }
}
