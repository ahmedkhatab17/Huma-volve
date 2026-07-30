import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciepe_app/core/error/error_handler.dart';
import 'package:reciepe_app/core/error/failure.dart';
import 'package:reciepe_app/feature/home/data/data_sources/home_data_source.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_category_entity.dart';
import 'package:reciepe_app/feature/home/domain/entity/home_meal_entity.dart';
import 'package:reciepe_app/feature/home/domain/repository/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeDataSource dataSource;
  HomeRepositoryImp(this.dataSource);
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final response = await dataSource.getCategories();
      final categories = response.map((e) => e.toEntity()).toList();
      return right(categories);
    } on DioException catch (e) {
      return left(HandleError.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<MealEntity>>> getMealsByCategory(
    String category,
  ) async {
    try {
      final response = await dataSource.getMealsByCategory(category);
      final meals = response.map((e) => e.toEntity()).toList();
      return right(meals);
    } on DioException catch (e) {
      return left(HandleError.handle(e));
    }
  }
}
